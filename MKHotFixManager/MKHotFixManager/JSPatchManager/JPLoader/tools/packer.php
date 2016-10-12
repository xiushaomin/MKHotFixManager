<?php 

const PRIVATE_KEY = <<<EOD
-----BEGIN RSA PRIVATE KEY-----
    
-----END RSA PRIVATE KEY-----

EOD;

$files = "";
$zipFile = "script.zip";
$finalFile = "v1";
for ($i = 1; $i < count($argv); $i ++) {
    if ($argv[$i] == '-o') {
        $finalFile = $argv[$i + 1];
        break;
    }
    $files .= $argv[$i] . " ";
}

if (!empty($files)) {

    //compress files
    echo system("zip $zipFile $files"); 

    //get and encrypt zip file's md5
    $zipFileMD5 = md5_file($zipFile);
    $private_key = openssl_pkey_get_private(PRIVATE_KEY);
    $ret = openssl_private_encrypt($zipFileMD5, $encrypted, $private_key);

    if (!$ret || empty($encrypted)) {
        unlink($zipFile);
        echo "fail to encrypt file md5";
    }

    $md5File = "key";
    file_put_contents($md5File, $encrypted);

    //pack script zip file and md5 file to final zip file
    echo system("zip $finalFile $zipFile $md5File"); 

    unlink($md5File);
    unlink($zipFile);
}
