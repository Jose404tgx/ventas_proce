<?php
include 'conexion.php';

$id = $_POST['id_proveedor'];
$razonsocial = $_POST['razonsocial'];
$direccion = $_POST['direccion'];
$telefono = $_POST['telefono'];

$stmt = $pdo->prepare("CALL actualizar_proveedor(?, ?, ?, ?)");
$stmt->execute([$id, $razonsocial, $direccion, $telefono]);

echo "Proveedor actualizado correctamente.";
?>
