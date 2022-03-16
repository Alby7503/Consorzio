<?php
session_start();
if (isset($_SESSION['user'])) {
    header('Location: Dashboard.php');
    die();
}
if (isset($_POST['username']) && isset($_POST['password'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];
    if ($username == 'admin' && $password == 'admin') {
        $_SESSION['user'] = $username;
        header('Location: Dashboard.php');
        die();
    }
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>

<body>
    <form method="POST">
        <div class="container">
            <div class="row">
                <div class="col-md-4 offset-md-4">
                    <h1 class="text-center">Login</h1>
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" class="form-control" id="username" name="username" placeholder="Username" autocomplete="username">
                    </div><br>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" autocomplete="current-password">
                    </div><br>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary btn-block">Login</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>

</html>