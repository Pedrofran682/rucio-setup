# Rucio Download and Unpack Script

This script automates the download, extraction, and organization of `.root.tgz` files from the Grid using Rucio. 

## Usage

1. **Ensure the script is executable:**
```bash
   chmod +x downloadUnpack.sh
```

2. **Initialize your environment:**
Make sure your grid environment and proxy are set up before running the script.

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

**Source execution (if you want to remain in the dataset's directory after execution):**

```bash
   source downloadUnpack.sh <DATASET_DID>
```

## Functional Logic

* **Automated Download:** Uses `rucio download` to fetch the dataset and validates if the download was successful.
* **Folder Navigation:** Automatically enters the directory created by Rucio (named after the Dataset DID).
* **Smart Extraction & Prefixing:** Reads the contents of each `.root.tgz` file and extracts them. Every extracted file is prefixed with the name of its specific source archive to prevent filename collisions (e.g., `archive_name.root.tgz_filename.root`).
* **Space Optimization (Cleanup):** Once an archive is successfully extracted and its contents renamed, the original `.root.tgz` file is **deleted** to save disk space.
* **Error Handling:** Checks for missing arguments, download failures, and extraction errors, providing clear terminal output for each step.

## Output Structure

Instead of creating subfolders, the script now extracts everything directly into the dataset directory and cleans up the compressed files. After a successful run, the structure will look like this:

```text
<DATASET_DID>/
├── <ARCHIVE_1_NAME>.root.tgz_<INTERNAL_FILE_1>.root
├── <ARCHIVE_1_NAME>.root.tgz_<INTERNAL_FILE_2>.root
└── <ARCHIVE_2_NAME>.root.tgz_<INTERNAL_FILE_3>.root
```

```</INTERNAL_FILE_3></ARCHIVE_2_NAME></INTERNAL_FILE_2></ARCHIVE_1_NAME></INTERNAL_FILE_1></ARCHIVE_1_NAME></DATASET_DID></DATASET_DID></DATASET_DID>
```