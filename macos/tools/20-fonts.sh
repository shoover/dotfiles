#!/bin/zsh

# Install some nice fonts recommended by https://practicaltypography.com/free-fonts.html.
#
# Downloads zip files and copies all OTF files to the user's fonts directory.

set -e

FONTS_DIR="$HOME/Library/Fonts"

# Font definitions: name, URL, subdirectory path to OTF files
fonts=(
    "IBMPlexSans-Regular.otf|https://github.com/IBM/plex/releases/download/%40ibm%2Fplex-sans%401.1.0/ibm-plex-sans.zip|ibm-plex-sans/fonts/complete/otf"
    "IBMPlexMono-Regular.otf|https://github.com/IBM/plex/releases/download/%40ibm%2Fplex-mono%401.1.0/ibm-plex-mono.zip|ibm-plex-mono/fonts/complete/otf"
    "IBMPlexSerif-Regular.otf|https://github.com/IBM/plex/releases/download/%40ibm%2Fplex-serif%401.1.0/ibm-plex-serif.zip|ibm-plex-serif/fonts/complete/otf"
    "CooperHewitt-Medium.otf|https://www.cooperhewitt.org/wp-content/uploads/fonts/CooperHewitt-OTF-public.zip|CooperHewitt-OTF-public/"
    "Charter Regular.otf|https://practicaltypography.com/fonts/Charter%20210112.zip|Charter 210112/OTF format (best for Mac OS)/Charter"
    "SourceSerif4Display-Regular.otf|https://github.com/adobe-fonts/source-serif/releases/download/4.005R/source-serif-4.005_Desktop.zip|source-serif-4.005_Desktop/OTF"
    "SourceSans3-Regular.otf|https://github.com/adobe-fonts/source-sans/releases/download/3.052R/OTF-source-sans-3.052R.zip|OTF"
    "SourceCodePro-Regular.otf|https://github.com/adobe-fonts/source-code-pro/releases/download/2.042R-u%2F1.062R-i%2F1.026R-vf/OTF-source-code-pro-2.042R-u_1.062R-i.zip|OTF"
)

for font_spec in "${fonts[@]}"; do
    IFS='|' read -r check_font url otf_path <<< "$font_spec"

    # Check if font is already installed
    if [ -f "$FONTS_DIR/$check_font" ]; then
        echo "$check_font is already installed. Skipping."
        continue
    fi

    echo "Installing fonts from $url..."

    temp_dir=$(mktemp -d)

    zip_file="$temp_dir/font.zip"
    curl -L -o "$zip_file" "$url"
    unzip -q "$zip_file" -d "$temp_dir"

    if [ -d "$temp_dir/$otf_path" ]; then
        cp "$temp_dir/$otf_path"/*.otf "$FONTS_DIR/"
        echo "Installed fonts from $otf_path"
    else
        echo "Warning: Could not find $otf_path in extracted archive"
    fi

    rm -rf "$temp_dir"
done
