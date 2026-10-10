<?php
session_start();

$host = "sql106.infinityfree.com";
$user = "if0_43075733";
$pass = "tecmarti2026"; // Cambia esto por tu contraseña de hosting/base de datos
$db   = "if0_43075733_tecmarti";

$conn = new mysqli($host,$user, $pass,$db);
if ($conn->connect_error) {
    die("<h2 style='color:red;'>Error de conexión: " . $conn->connect_error . "</h2>");
}
$conn->set_charset("utf8mb4");

// Manejo de inicio de sesión de administrador
if (isset($_POST['login'])) {
    if ($_POST['password'] === 'Admin123*') { // Contraseña de acceso para editar (puedes cambiarla aquí)
        $_SESSION['admin'] = true;
    } else {
        $error_login = "Contraseña incorrecta.";
    }
}
if (isset($_GET['logout'])) {
    unset($_SESSION['admin']);
    header("Location: index.php");
    exit();
}

// Manejo de actualización de datos en la base de datos
$mensaje_exito = "";
if (isset($_SESSION['admin']) && isset($_POST['guardar_cambios'])) {$tabla_act = $_POST['tabla'];$id_col = $_POST['id_col'];$id_val = $_POST['id_val'];$updates = [];
    foreach ($_POST['campo'] as $columna =>$valor) {
        $val_esc =$conn->real_escape_string($valor);$updates[] = "`$columna` = '$val_esc'";
    }
    
    $sql_update = "UPDATE `$tabla_act` SET " . implode(", ", $updates) . " WHERE `$id_col` = '$id_val'";
    if ($conn->query($sql_update)) {$mensaje_exito = "¡Registro actualizado correctamente en la tabla '$tabla_act'!";
    } else {
        $mensaje_exito = "Error al actualizar: " . $conn->error;
    }
}

// Obtener datos para las gráficas
$result_creditos =$conn->query("SELECT Creditos, COUNT(*) as Total FROM materia GROUP BY Creditos");
$data_creditos = [];
while($row = $result_creditos->fetch_assoc()) {$data_creditos[] = [$row['Creditos'] . ' Créditos', (int)$row['Total']];
}

$result_calif =$conn->query("SELECT m.Nombre, AVG(c.Calificacion) as Promedio FROM calificaciones c JOIN materia m ON c.IdMateria = m.IdMateria GROUP BY m.IdMateria, m.Nombre");
$data_calif = [];
while($row = $result_calif->fetch_assoc()) {$data_calif[] = [$row['Nombre'], (float)$row['Promedio']];
}

$tablas = ['alumnos', 'calificaciones', 'carga', 'carrera', 'ciclo', 'grupo', 'materia', 'personas'];
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Sistema Académico - Tecmarti</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawCharts);

      function drawCharts() {
        var dataCreditos = google.visualization.arrayToDataTable([
          ['Créditos', 'Cantidad'],
          <?php foreach($data_creditos as$row) { echo "['" . $row[0] . "', " . $row[1] . "],"; } ?>
        ]);
        var chartCreditos = new google.visualization.PieChart(document.getElementById('donut_chart'));
        chartCreditos.draw(dataCreditos, { title: 'Distribución de Materias por Créditos', pieHole: 0.4, colors: ['#0056b3', '#28a745', '#ffc107'] });

        var dataCalif = google.visualization.arrayToDataTable([
          ['Materia', 'Promedio'],
          <?php foreach($data_calif as$row) { echo "['" . addslashes($row[0]) . "', " . $row[1] . "],"; } ?>
        ]);
        var chartCalif = new google.visualization.ColumnChart(document.getElementById('column_chart'));
        chartCalif.draw(dataCalif, { title: 'Promedio de Calificaciones por Materia', legend: { position: 'none' }, colors: ['#0056b3'], vAxis: { minValue: 0, maxValue: 100 } });
      }
    </script>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f8f9fa; color: #333; }
        h1 { color: #2c3e50; text-align: center; }
        .admin-bar { background: #343a40; color: white; padding: 10px 20px; border-radius: 5px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .admin-bar a, .admin-bar button { background: #007bff; color: white; border: none; padding: 6px 12px; border-radius: 4px; text-decoration: none; cursor: pointer; }
        .admin-bar a.logout { background: #dc3545; }
        .charts-container { display: flex; flex-wrap: wrap; justify-content: space-around; margin-bottom: 30px; }
        .chart-box { background: #fff; padding: 15px; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); width: 45%; min-width: 300px; margin-bottom: 20px; }
        h2 { color: #0056b3; margin-top: 40px; border-bottom: 2px solid #0056b3; padding-bottom: 5px; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 20px; background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
        th, td { border: 1px solid #dddddd; text-align: left; padding: 10px; font-size: 14px; }
        th { background-color: #0056b3; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .btn-edit { background: #ffc107; color: #000; padding: 4px 10px; border-radius: 3px; border: none; cursor: pointer; font-size: 12px; font-weight: bold; }
        .modal { display: none; position: fixed; z-index: 99; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); overflow-y: auto; }
        .modal-content { background: #fff; margin: 5% auto; padding: 20px; width: 50%; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.2); }
        .close { float: right; font-size: 24px; cursor: pointer; color: #aaa; }
        .form-group { margin-bottom: 12px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 4px; font-size: 13px; }
        .form-group input { width: 100%; padding: 8px; box-sizing: border-box; border: 1px solid #ccc; border-radius: 4px; }
        @media (max-width: 768px) { .chart-box { width: 100%; } .modal-content { width: 90%; } }
    </style>
</head>
<body>

<div class="admin-bar">
    <span><strong>Panel Tecmarti</strong></span>
    <?php if (isset($_SESSION['admin'])): ?>
        <span>Modo Administrador Activo <a href="?logout=true" class="logout">Cerrar Sesión</a></span>
    <?php else: ?>
        <button onclick="document.getElementById('loginModal').style.display='block'">🔑 Modo Administrador (Editar)</button>
    <?php endif; ?>
</div>

<?php if(!empty($mensaje_exito)): ?>
    <p style='background:#d4edda; color:#155724; padding:12px; border-radius:5px; text-align:center;'><strong><?php echo $mensaje_exito; ?></strong></p>
<?php endif; ?>

<h1>Sistema Académico e Interfaz de Datos</h1>
<p style="text-align: center;"><strong>Servidor:</strong> <?php echo $host; ?></p>

<!-- Modal de Login -->
<div id="loginModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="document.getElementById('loginModal').style.display='none'">&times;</span>
        <h3>Acceso Restringido para Edición</h3>
        <?php if(isset($error_login)) echo "<p style='color:red;'>$error_login</p>"; ?>
        <form method="POST">
            <div class="form-group">
                <label>Contraseña de Administrador:</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" name="login" style="background:#28a745; color:white; border:none; padding:8px 15px; border-radius:4px; cursor:pointer;">Entrar</button>
        </form>
    </div>
</div>

<!-- Gráficas -->
<div class="charts-container">
    <div class="chart-box"><div id="donut_chart" style="width: 100%; height: 300px;"></div></div>
    <div class="chart-box"><div id="column_chart" style="width: 100%; height: 300px;"></div></div>
</div>

<hr style="border: 0; border-top: 1px solid #ccc; margin: 40px 0;">

<!-- Listado de Tablas -->
<?php
foreach ($tablas as$tabla) {
    echo "<h2>Tabla: " . htmlspecialchars($tabla) . "</h2>";
    $result =$conn->query("SELECT * FROM `$tabla`");

    if ($result &&$result->num_rows > 0) {
        echo "<div style='overflow-x:auto;'><table><thead><tr>";
        $fields = $result->fetch_fields();$primary_key = "";
        foreach ($fields as$field) {
            if ($field->flags & MYSQLI_PRI_KEY_FLAG) {
                $primary_key =$field->name;
                break;
            }
        }
        if(!$primary_key) { $primary_key =$fields[0]->name; }

        foreach ($fields as$field) {
            echo "<th>" . htmlspecialchars($field->name) . "</th>";
        }
        if (isset($_SESSION['admin'])) {
            echo "<th>Acciones</th>";
        }
        echo "</tr></thead><tbody>";

        while ($row =$result->fetch_assoc()) {
            echo "<tr>";
            foreach ($row as$cell) {
                echo "<td>" . htmlspecialchars($cell ?? '') . "</td>";
            }
            
            if (isset($_SESSION['admin'])) {$id_val_row = $row[$primary_key];
                // Codificar la fila en JSON seguro para pasarla al modal de edición
                $row_json = htmlspecialchars(json_encode($row), ENT_QUOTES, 'UTF-8');
                echo "<td><button type='button' onclick='abrirEditar(\"$tabla\", \"$primary_key\", $row_json)' class='btn-edit'>Editar</button></td>";
            }
            echo "</tr>";
        }
        echo "</tbody></table></div>";
    } else {
        echo "<p><em>No hay registros disponibles.</em></p>";
    }
}
$conn->close();
?>

<!-- Modal de Edición de Registro -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="document.getElementById('editModal').style.display='none'">&times;</span>
        <h3 id="modal-title">Editar Registro</h3>
        <form method="POST" id="editForm">
            <input type="hidden" name="tabla" id="edit_tabla">
            <input type="hidden" name="id_col" id="edit_id_col">
            <input type="hidden" name="id_val" id="edit_id_val">
            <div id="form-fields-container"></div>
            <br>
            <button type="submit" name="guardar_cambios" style="background:#28a745; color:white; border:none; padding:10px 20px; border-radius:4px; cursor:pointer; font-weight:bold;">Guardar Cambios</button>
        </form>
    </div>
</div>

<script>
function abrirEditar(tabla, id_col, rowData) {
    document.getElementById('editModal').style.display = 'block';
    document.getElementById('modal-title').innerText = "Editar Registro en: " + tabla;
    document.getElementById('edit_tabla').value = tabla;
    document.getElementById('edit_id_col').value = id_col;
    document.getElementById('edit_id_val').value = rowData[id_col];

    let container = document.getElementById('form-fields-container');
    container.innerHTML = "";

    for (let key in rowData) {
        let div = document.createElement('div');
        div.className = 'form-group';
        
        let label = document.createElement('label');
        label.innerText = key + (key === id_col ? " (ID - No editable)" : "");
        div.appendChild(label);

        let input = document.createElement('input');
        input.type = 'text';
        input.name = "campo[" + key + "]";
        input.value = rowData[key] !== null ? rowData[key] : "";
        
        // Bloquear la edición de la llave primaria para evitar errores de integridad
        if (key === id_col) {
            input.readOnly = true;
            input.style.backgroundColor = "#e9ecef";
        }

        div.appendChild(input);
        container.appendChild(div);
    }
}
</script>

</body>
</html>