function my_formatSize($size) {
    var size = parseFloat($size);
    var rank = 0;
    var rankchar = 'B';
    while (size > 1024) {
        size = size / 1024;
        rank++;
    }
    if (rank == 1) {
        rankchar = "KB";
    } else if (rank == 2) {
        rankchar = "MB";
    } else if (rank == 3) {
        rankchar = "GB";
    } else if (rank == 4) {
        rankchar = "TB";
    }
    return size.toFixed(2) + " " + rankchar;
}

function readablizeBytes(bytes) {
    var s = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    var e = Math.floor(Math.log(bytes) / Math.log(1024));
    return (bytes / Math.pow(1024, e)).toFixed(2) + " " + s[e];
}

function formatSize(bytes) {
    var s = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    var e = 0;
    while (bytes >= 1024) {
        bytes /= 1024;
        e++;
    }
    return bytes.toFixed(2) + " " + s[e];
}
function formatSize(bytes) {
    const s = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    var e = 0;
    while (bytes >= 1024) {
        bytes = bytes >> 10;
        e++;
    }
    return bytes.toFixed(2) + " " + s[e];
}
