<?php
session_start();
if (!isset($_SESSION['user'])) {
    header('Location: /');
    die();
}
$errors = '';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $fields = ['name' => 'Nome', 'seasoning' => 'Stagionatura', 'choice' => 'Scelta', 'date' => 'Data di produzione'];
    foreach ($fields as $key => $value) {
        if (!isset($_POST[$value])) {
            $errors .= "<div class=\"alert alert-danger\" role=\"alert\">Parametro mancante: $value</div>";
        }
    }
    if ($errors == '') {
        $conn = new mysqli('localhost', 'root', '', 'consorzio');
        $conn->close();
    }
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>

<body>
    <div class="container">
        <button onclick="window.location.href='Logout.php'" style="float: right;">Logout</button>
        <h1>Benvenuto <?php echo $_SESSION['user']; ?></h1>
        <br>
        <form method="POST">
            <div class="form-group">
                <label for="name">Nome</label>
                <input type="text" class="form-control" id="name" placeholder="Formaggio ...">
            </div><br>
            <div class="row">
                <div class="form-group col-md-9">
                    <label for="seasoning">Stagionatura</label>
                    <input type="number" min="0" class="form-control" id="seasoning" placeholder="0 - ∞">
                </div>
                <div class="form-group col-md-1 d-flex align-items-center" style="margin-top: 2% !important;">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="time" id="week" value="week">
                        <label class="form-check-label" for="week">Settimane</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="time" id="month" value="month">
                        <label class="form-check-label" for="month">Mesi</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="time" id="year" value="year">
                        <label class="form-check-label" for="year">Anni</label>
                    </div>
                </div>
            </div><br>
            <div class="form-group">
                <label for="choice">Scegli una scelta</label>
                <select id="choice" class="form-control">
                    <option value="1" selected>1a scelta</option>
                    <option value="2">2a scelta</option>
                    <option value="0">Altro</option>
                </select>
            </div><br>
            <div class="form-group">
                <label for="date">Data produzione</label>
                <input type="date" class="form-control" id="date">
            </div><br>
            <div class="text-center">
                <input type="submit" class="btn btn-primary" value="Invia">
            </div>
        </form><br>
        <?php
        echo $errors;
        ?>
    </div>
    <script>
        const local = new Date();
        local.setMinutes(local.getMinutes() - local.getTimezoneOffset());
        let dateString = local.toISOString().substring(0, 10);
        document.getElementById("date").value = dateString;
    </script>
</body>

</html>