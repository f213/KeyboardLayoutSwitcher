/*
 --------------------------------------------------------------------------
 Keyboard Layout Switcher | Written by Alexander Belov | http://github.com/porqz
 --------------------------------------------------------------------------
 
 Don’t forget include Carbon.framework to compile this:
 
 In Group & Files frame make right click on External Frameworks and 
 Libraries → Add → Existing Frameworks… 
 
 Choose Carbon.framework and press button Add.
 
 --------------------------------------------------------------------------
 
 Run this application:
 
	 without arguments to see index of current keyboard layout
	 or
	 with number to switch keyboard layout to keyboard layout with index
 
		 Will printed:
			Nothing  if application ended normally
			-1	 if there is no keyboard layout with the index
 
 --------------------------------------------------------------------------
 P. S.: I am not hindu, I am just not Objective-C programmer ;).
 --------------------------------------------------------------------------
 */

#import <Carbon/Carbon.h>

int main (int argc, const char * argv[]) {
	// Get enabled keyboard layouts list
	CFArrayRef sourceList = TISCreateInputSourceList (NULL, false);
	
	// If the application was run with argument(s)
	if (argc > 1) {
		// Get the first argument. It is index of wanted keyboard layout
		int wantedSourceIndex = atoi(argv[1]);
		// Get wanted keyboard layout by index
		TISInputSourceRef wantedSource = CFArrayGetValueAtIndex(sourceList, wantedSourceIndex);
		
		// If a keyboard layout with the index does not exist
		if (!wantedSource) {
			printf("%d", -1);
			
			return 1;
		}
		
		// Switch to wanted keyboard layout
		TISSelectInputSource(wantedSource);
	}
	// If the application was run without arguments
	else {
		// Get current keyborad layout
		TISInputSourceRef currentSource = TISCopyCurrentKeyboardInputSource();
		int sourceCount = CFArrayGetCount(sourceList);
		
		// Search an index of the keyboard layout
		for (int i = 0; i < sourceCount; i++)
			// If the index is found
			if (TISGetInputSourceProperty(CFArrayGetValueAtIndex(sourceList, i), kTISPropertyLocalizedName) == TISGetInputSourceProperty(currentSource, kTISPropertyLocalizedName)) {
				// Print the index
				printf("%d", i);
				
				return 0;
			}
	}
	
	return 0;
}
