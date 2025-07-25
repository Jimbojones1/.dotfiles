summarize() {
  # Check if both arguments were provided
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: summarize <path_to_source> <output_file.md>"
    return 1 # Exit the function with an error
  fi

  # New, more detailed instructions for the Gemini model
  local instructions="Summarize the attached project files. Then, analyze the code to identify commands and scripts. Specifically:
1.  **List any essential commands or runnable scripts that already exist** in the project and explain what each one does.
2.  **If no existing commands or scripts are found, suggest some relevant commands** that would be useful for building, running, or testing this project."

  gemini -p "${instructions} @$1" > "$2"
  echo "Summary complete. Output written to $2"
}

# Function to explain a code file
explain() {
  if [ -z "$1" ]; then
    echo "Usage: explain <path_to_file>"
    return 1
  fi

  gemini -p "Explain the following code from the file provided. Describe its purpose, inputs, and outputs in a clear, concise way. @$1"
}

# Function to generate an ffmpeg command from a description
ffm() {
  if [ -z "$*" ]; then
    echo "Usage: ffm <a description of the ffmpeg task>" >&2
    echo "Example: ffm convert video.mp4 to audio_only.mp3" >&2
    return 1
  fi

  local instructions="You are an ffmpeg expert. Convert the following plain English request into a single, correct ffmpeg command. Return ONLY the command itself, with no explanation, comments, or markdown fences."

  gemini -p "${instructions}

### Request:
$*"
}

# Function to decline a Latin noun or adjective
decline() {
  if [ -z "$1" ]; then
    echo "Usage: decline \"<word>, <declension_info>\"" >&2
    echo "Example: decline \"puella, 1st declension feminine\"" >&2
    return 1
  fi

  local instructions="You are a Latin grammar expert. Provide the full declension table (nominative, genitive, dative, accusative, ablative, vocative; singular and plural) for the following Latin word. Clearly label each case."

  gemini -p "${instructions}

### Word to decline:
$*"
}
