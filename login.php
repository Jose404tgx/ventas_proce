<?php
session_start();
include 'conexion.php';
header('Content-Type: application/json');

$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

if (!$email || !$password) {
    echo json_encode(['success' => false, 'message' => 'Correo y contraseña son obligatorios.']);
    exit;
}

try {
    $stmt = $pdo->prepare("CALL obtener_usuario_por_email(?)");
    $stmt->execute([$email]);
    $usuario = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($usuario) {
        // Solo permitir login a administrador o encargado
        if (!in_array($usuario['rol'], ['administrador', 'encargado'])) {
            echo json_encode(['success' => false, 'message' => 'No tienes permiso para iniciar sesión.']);
            exit;
        }

        if (password_verify($password, $usuario['password'])) {
            $_SESSION['id_usuario'] = $usuario['id_usuario'];
            $_SESSION['nombre'] = $usuario['nombre'];
            $_SESSION['rol'] = $usuario['rol'];

            // Redirigir según el rol
            if ($usuario['rol'] === 'administrador') {
                echo json_encode(['success' => true, 'redirect' => 'productos.html']);
            } elseif ($usuario['rol'] === 'encargado') {
                echo json_encode(['success' => true, 'redirect' => 'ventas.php']);
            }
        } else {
            echo json_encode(['success' => false, 'message' => 'Contraseña incorrecta.']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Usuario no encontrado.']);
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Error en el servidor.']);
}
?>
