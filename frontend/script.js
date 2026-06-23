const API_URL =
"https://ijwddaj0wf.execute-api.ap-south-1.amazonaws.com/files";

const DOWNLOAD_API =
"https://ijwddaj0wf.execute-api.ap-south-1.amazonaws.com/download";

const UPLOAD_API =
"https://cxn52wbpql.execute-api.ap-south-1.amazonaws.com/upload-url";

const DELETE_API =
"https://qu9xu84x3j.execute-api.ap-south-1.amazonaws.com/delete";


async function uploadFile() {

    const fileInput = document.getElementById("fileInput");

    if (!fileInput.files.length) {
        alert("Please select a file");
        return;
    }

    const file = fileInput.files[0];

    try {

        const response = await fetch(
            `${UPLOAD_API}?fileName=${encodeURIComponent(file.name)}`
        );

        const data = await response.json();

        const result = await fetch(data.uploadUrl, {
            method: "PUT",
            body: file,
            headers: {
                "Content-Type": file.type
            }
        });

        if (!result.ok) {
            throw new Error("Upload failed");
        }

        alert("Upload Successful!");

        loadFiles();

    } catch (error) {

        console.error("Upload Error:", error);

        alert("Upload Failed");

    }
}


async function downloadFile(fileName) {

    try {

        const response = await fetch(
            `${DOWNLOAD_API}?fileName=${encodeURIComponent(fileName)}`
        );

        const data = await response.json();

        window.open(data.downloadUrl, "_blank");

    } catch (error) {

        console.error(error);

        alert("Download Failed");

    }
}


async function deleteFile(fileid, fileName) {

    if (!confirm(`Delete ${fileName}?`)) {
        return;
    }

    try {

        const response = await fetch(
            `${DELETE_API}?fileid=${encodeURIComponent(fileid)}&fileName=${encodeURIComponent(fileName)}`
        );

        const data = await response.json();

        alert(data.message);

        loadFiles();

    } catch (error) {

        console.error(error);

        alert("Delete Failed");

    }
}


async function loadFiles() {

    try {

        const response = await fetch(API_URL, {
            method: "GET",
            mode: "cors"
        });

        const files = await response.json();

        const tableBody =
            document.querySelector("#fileTable tbody");

        tableBody.innerHTML = "";

        files.forEach(file => {

            const row = `
                <tr>
                    <td>${file.fileName}</td>
                    <td>${file.contentType}</td>
                    <td>${file.fileSize}</td>
                    <td>${file.uploadTime}</td>

                    <td>
                        <button onclick="downloadFile('${file.fileName}')">
                            Download
                        </button>
                    </td>

                    <td>
                        <button onclick="deleteFile('${file.fileid}','${file.fileName}')">
                            Delete
                        </button>
                    </td>
                </tr>
            `;

            tableBody.innerHTML += row;
        });

    } catch (error) {

        console.error("Error loading files:", error);

        alert("Failed to load files");

    }
}