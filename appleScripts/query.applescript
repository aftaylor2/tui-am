on run argv
    set searchQuery to item 1 of argv
    
    tell application "Music"
        try
            set searchResults to search playlist "Library" for searchQuery
            
            if (count of searchResults) > 0 then
                set output to "Found " & (count of searchResults) & " result(s) for '" & searchQuery & "':" & return & return
                
                -- Store the first track to play it
                set firstTrack to item 1 of searchResults
                
                repeat with i from 1 to count of searchResults
                    set theTrack to item i of searchResults
                    set trackInfo to (i as string) & ". " & name of theTrack & " - " & artist of theTrack & " (" & album of theTrack & ")"
                    set output to output & trackInfo & return
                    
                    if i >= 10 then
                        set output to output & return & "... and " & ((count of searchResults) - 10) & " more result(s)"
                        exit repeat
                    end if
                end repeat
                
                -- Play the first/best match
                play firstTrack
                set output to output & return & "▶ Now playing: " & name of firstTrack & " - " & artist of firstTrack
                
                return output
            else
                return "No results found for '" & searchQuery & "'"
            end if
        on error errMsg
            return "Error searching: " & errMsg
        end try
    end tell
end run