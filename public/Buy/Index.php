<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compra</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.2.1/dist/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
</head>

<body>
    <div class="container">
        <h1>Elenco formaggi</h1><br>
        <div class="card-deck">
            <?php
            $products = json_decode(file_get_contents('products.json'), true);
            foreach ($products as $key => $value) {
                $name = $value['name'];
                $description = $value['description'];
                $image = $value['image'];
                echo "<div class=\"card\" style=\"width: 18rem;\"><img class=\"card-img-top\" src=\"Images/$image\" alt=\"$name\"><div class=\"card-body\"><p class=\"card-text\">$description</p></div></div>";
            }
            ?>
        </div>
    </div>

</body>

</html>