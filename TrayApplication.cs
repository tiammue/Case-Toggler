using System;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Text;
using System.Windows.Forms;

namespace CaseToggler
{
    public class TrayApplication : ApplicationContext
    {
        private NotifyIcon trayIcon;
        private GlobalKeyboardHook keyboardHook;
        private DateTime lastShiftPress = DateTime.MinValue;
        private DateTime secondLastShiftPress = DateTime.MinValue;
        private const int DOUBLE_TAP_THRESHOLD_MS = 300;
        private const int TRIPLE_TAP_THRESHOLD_MS = 500;

        public TrayApplication()
        {
            InitializeTrayIcon();
            InitializeKeyboardHook();
        }

        private void InitializeTrayIcon()
        {
            trayIcon = new NotifyIcon()
            {
                Icon = CreateIcon(),
                ContextMenuStrip = CreateContextMenu(),
                Visible = true,
                Text = "Case Toggler - Double/Triple tap LEFT SHIFT to toggle case"
            };
        }

        private Icon CreateIcon()
        {
            // Create "Aa" icon with black text on white background
            var bitmap = new Bitmap(32, 32);
            using (var g = Graphics.FromImage(bitmap))
            {
                // Enable anti-aliasing for smoother text
                g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;
                g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.AntiAlias;
                
                // White background with subtle border
                g.Clear(Color.White);
                g.DrawRectangle(new Pen(Color.LightGray, 1), 0, 0, 31, 31);
                
                // Black "Aa" text, centered
                using (var font = new Font("Segoe UI", 14, FontStyle.Bold))
                {
                    var textSize = g.MeasureString("Aa", font);
                    var x = (32 - textSize.Width) / 2;
                    var y = (32 - textSize.Height) / 2;
                    
                    g.DrawString("Aa", font, Brushes.Black, x, y);
                }
            }
            return Icon.FromHandle(bitmap.GetHicon());
        }

        private ContextMenuStrip CreateContextMenu()
        {
            var menu = new ContextMenuStrip();
            
            var aboutItem = new ToolStripMenuItem("About");
            aboutItem.Click += (s, e) => MessageBox.Show(
                "Case Toggler v1.0\n\n" +
                "Double tap LEFT SHIFT: Toggle case of selected text\n" +
                "Triple tap LEFT SHIFT: Toggle first letter of current word\n\n" +
                "• Lowercase → UPPERCASE\n• UPPERCASE → lowercase\n\n" +
                "Timing:\n" +
                "• Double-tap window: " + DOUBLE_TAP_THRESHOLD_MS + "ms\n" +
                "• Triple-tap window: " + TRIPLE_TAP_THRESHOLD_MS + "ms", 
                "About Case Toggler", 
                MessageBoxButtons.OK, 
                MessageBoxIcon.Information);
            
            var exitItem = new ToolStripMenuItem("Exit");
            exitItem.Click += (s, e) => ExitApplication();
            
            menu.Items.Add(aboutItem);
            menu.Items.Add(new ToolStripSeparator());
            menu.Items.Add(exitItem);
            
            return menu;
        }

        private void InitializeKeyboardHook()
        {
            keyboardHook = new GlobalKeyboardHook();
            keyboardHook.KeyDown += OnKeyDown;
        }

        private void OnKeyDown(object sender, Keys key)
        {
            if (key == Keys.LShiftKey)
            {
                var now = DateTime.Now;
                var timeSinceLastPress = (now - lastShiftPress).TotalMilliseconds;
                var timeSinceSecondLastPress = (now - secondLastShiftPress).TotalMilliseconds;
                
                if (timeSinceLastPress <= DOUBLE_TAP_THRESHOLD_MS && timeSinceSecondLastPress <= TRIPLE_TAP_THRESHOLD_MS)
                {
                    // Triple tap detected!
                    ToggleCurrentWordFirstLetter();
                    lastShiftPress = DateTime.MinValue;
                    secondLastShiftPress = DateTime.MinValue;
                }
                else if (timeSinceLastPress <= DOUBLE_TAP_THRESHOLD_MS)
                {
                    // Double tap detected!
                    ToggleSelectedTextCase();
                    // Don't reset here - allow for potential triple tap
                    secondLastShiftPress = lastShiftPress;
                    lastShiftPress = now;
                }
                else
                {
                    secondLastShiftPress = lastShiftPress;
                    lastShiftPress = now;
                }
            }
        }

        private void ToggleSelectedTextCase()
        {
            try
            {
                // Store original clipboard content to restore later
                string originalClipboard = "";
                bool hadClipboardContent = false;
                
                if (Clipboard.ContainsText())
                {
                    originalClipboard = Clipboard.GetText();
                    hadClipboardContent = true;
                }
                
                // Send Ctrl+X to cut selected text (this removes it and copies it)
                SendKeys.SendWait("^x");
                
                // Wait for clipboard to change with timeout
                string newClipboardContent = WaitForClipboardChange(originalClipboard, 200);
                
                if (!string.IsNullOrEmpty(newClipboardContent) && newClipboardContent != originalClipboard)
                {
                    string toggledText = ToggleCase(newClipboardContent);
                    Clipboard.SetText(toggledText);
                    
                    // Send Ctrl+V to paste the toggled text
                    SendKeys.SendWait("^v");
                }
                
                // Restore original clipboard content immediately
                if (hadClipboardContent)
                {
                    Clipboard.SetText(originalClipboard);
                }
                else
                {
                    Clipboard.Clear();
                }
            }
            catch (Exception ex)
            {
                // Silently handle clipboard errors
                System.Diagnostics.Debug.WriteLine("Error toggling case: " + ex.Message);
            }
        }

        private void ToggleCurrentWordFirstLetter()
        {
            try
            {
                // Store original clipboard content to restore later
                string originalClipboard = "";
                bool hadClipboardContent = false;
                
                if (Clipboard.ContainsText())
                {
                    originalClipboard = Clipboard.GetText();
                    hadClipboardContent = true;
                }
                
                // Select current word using Ctrl+Left then Ctrl+Shift+Right
                SendKeys.SendWait("^{LEFT}^+{RIGHT}");
                
                // Copy the selected word
                SendKeys.SendWait("^c");
                
                // Wait for clipboard to change with timeout
                string currentWord = WaitForClipboardChange(originalClipboard, 200);
                
                if (!string.IsNullOrEmpty(currentWord) && currentWord != originalClipboard)
                {
                    string toggledWord = ToggleFirstLetterCase(currentWord);
                    Clipboard.SetText(toggledWord);
                    
                    // Paste the modified word
                    SendKeys.SendWait("^v");
                }
                
                // Restore original clipboard content immediately
                if (hadClipboardContent)
                {
                    Clipboard.SetText(originalClipboard);
                }
                else
                {
                    Clipboard.Clear();
                }
            }
            catch (Exception ex)
            {
                // Silently handle clipboard errors
                System.Diagnostics.Debug.WriteLine("Error toggling word case: " + ex.Message);
            }
        }

        private string WaitForClipboardChange(string originalContent, int timeoutMs)
        {
            var startTime = DateTime.Now;
            
            while ((DateTime.Now - startTime).TotalMilliseconds < timeoutMs)
            {
                Application.DoEvents(); // Process Windows messages
                
                try
                {
                    if (Clipboard.ContainsText())
                    {
                        string currentContent = Clipboard.GetText();
                        if (currentContent != originalContent)
                        {
                            return currentContent; // Clipboard changed!
                        }
                    }
                }
                catch
                {
                    // Clipboard might be locked, continue trying
                }
                
                // Tiny yield to prevent 100% CPU usage
                System.Threading.Thread.Yield();
            }
            
            // Timeout reached, return current clipboard content
            try
            {
                return Clipboard.ContainsText() ? Clipboard.GetText() : "";
            }
            catch
            {
                return "";
            }
        }

        private string ToggleFirstLetterCase(string text)
        {
            if (string.IsNullOrEmpty(text))
                return text;
                
            char[] chars = text.ToCharArray();
            
            // Find the first letter and toggle its case
            for (int i = 0; i < chars.Length; i++)
            {
                if (char.IsLetter(chars[i]))
                {
                    chars[i] = char.IsUpper(chars[i]) ? char.ToLower(chars[i]) : char.ToUpper(chars[i]);
                    break; // Only toggle the first letter
                }
            }
            
            return new string(chars);
        }

        private string ToggleCase(string text)
        {
            // Use char array for faster manipulation
            char[] chars = text.ToCharArray();
            
            for (int i = 0; i < chars.Length; i++)
            {
                char c = chars[i];
                if (char.IsLetter(c))
                {
                    chars[i] = char.IsUpper(c) ? char.ToLower(c) : char.ToUpper(c);
                }
            }
            
            return new string(chars);
        }

        private void ExitApplication()
        {
            if (keyboardHook != null)
                keyboardHook.Dispose();
            trayIcon.Visible = false;
            if (trayIcon != null)
                trayIcon.Dispose();
            Application.Exit();
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                ExitApplication();
            }
            base.Dispose(disposing);
        }
    }
}