<?php
include 'conexion.php';

$razonsocial = $_POST['razonsocial'];
$direccion = $_POST['direccion'];
$telefono = $_POST['telefono'];

$stmt = $pdo->prepare("CALL crear_proveedor(?, ?, ?)");
$stmt->execute([$razonsocial, $direccion, $telefono]);

echo "Proveedor creado correctamente.";
?>
