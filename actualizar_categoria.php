<?php
include 'conexion.php';

$id = $_POST['id_categoria'];
$descripcion = $_POST['descripcion'];

$stmt = $pdo->prepare("CALL actualizar_categoria(?, ?)");
$stmt->execute([$id, $descripcion]);

echo "Categoría actualizada correctamente.";
?>
