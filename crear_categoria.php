<?php
include 'conexion.php';

$descripcion = $_POST['descripcion'];

$stmt = $pdo->prepare("CALL crear_categoria(?)");
$stmt->execute([$descripcion]);

echo "Categoría creada correctamente.";
?>
