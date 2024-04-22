<?php

function connect_bdd(){
    $host = "localhost";
    $dbname = "adoption";
    $user = "root";
    $pass = "";

    try{
        $pdo = new PDO("mysql:host=$host;dbname=$dbname", $user, $pass);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $pdo;
    } catch (PDOException $e){
        echo "Erreur de connexion : " . $e->getMessage();
        exit();
    }


}
