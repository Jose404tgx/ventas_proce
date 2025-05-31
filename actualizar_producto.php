<?php
include 'conexion.php';

$id = $_POST['id_producto'];
$descripcion = $_POST['descripcion'];
$precio = $_POST['precio'];
$stock = $_POST['stock'];
$id_categoria = $_POST['id_categoria'];
$id_proveedor = $_POST['id_proveedor'];

$stmt = $pdo->prepare("CALL actualizar_producto(?, ?, ?, ?, ?, ?)");
$stmt->execute([$id, $descripcion, $precio, $stock, $id_categoria, $id_proveedor]);

echo "Producto actualizado correctamente.";
?>
