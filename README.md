# Rucio Download and Unpack Script

This script automates the download, extraction, and organization of `.root.tgz` files from the Grid.

## Usage

1. **Ensure the script is executable:**
   ```bash
   chmod +x downloadUnpack.sh
   ```

2. **Initialize your environment:**
   ```bash
   lsetup rucio
   voms-proxy-init -voms atlas  # Or your specific VO
   ```

3. **Run the script:**
   Pass the **Dataset DID** as the first argument.

   **Standard execution:**
   ```bash
   ./downloadUnpack.sh <DATASET_DID>
   ```

   **Source execution (to remain in the script's final directory):**
   ```bash
   souce downloadUnpack.sh <DATASET_DID>
   ```

## Functional Logic

*   **Proxy Check:** Validates VOMS proxy before starting.
*   **Quiet Mode:** Suppresses output from `tar`, `mv`, and `voms` using `&> /dev/null`.
*   **Folder Navigation:** Automatically enters the directory created by Rucio (named after the DID).
*   **Prefixing:** Every extracted file is prefixed with the name of its specific source archive (e.g., `archive_name.root.tgz_filename.root`).
*   **Organization:** 
    *   `extracted_results/`: Contains all uncompressed and renamed files.
    *   `original_backups/`: Stores the original `.root.tgz` files after successful extraction.

## Output Structure
```text
<DATASET_DID>/
├── extracted_results/
│   └── <ARCHIVE_NAME>.root.tgz_<FILE_NAME>.root
└── original_backups/
    └── <ARCHIVE_NAME>.root.tgz
```
