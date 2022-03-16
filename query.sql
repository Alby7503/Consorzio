SET
    @oggi = CURRENT_DATE;
SET
    @ieri = DATE_SUB(@oggi, INTERVAL 1 DAY);
SET
    @domani = DATE_ADD(@oggi, INTERVAL 1 DAY);
/*
a) Visualizzare il numero di forme prodotte da ciascun caseificio tra due date fornite
*/
SELECT
    caseificio.ID_Caseificio,
    COUNT(forma.ID_Forma) AS SOMMA
FROM
    forma,
    caseificio
WHERE
    forma.cod_caseificio = caseificio.ID_Caseificio AND forma.Data_Produzione BETWEEN @ieri AND @domani
GROUP BY
    caseificio.ID_Caseificio
ORDER BY
    SOMMA
DESC;
/*
b) Visualizzare la media del latte lavorato giornalmente nell’anno corrente dai caseifici provincia per provincia
*/
SELECT
    caseificio.Provincia,
    AVG(utilizzo.Latte_Lavorato) AS MEDIA
FROM
    utilizzo,
    caseificio
WHERE
    utilizzo.cod_caseificio = caseificio.ID_Caseificio
GROUP BY
    caseificio.Provincia;
/*
c) Visualizzare i dati del caseificio che ha venduto il maggior numero di forme di prima scelta in un anno impostato dall’utente

Per arrivare a questa soluzione ho dovuto combattere con le PROCEDURE...
*/
SELECT
    caseificio.*
FROM
    forma,
    caseificio
WHERE
    forma.Scelta = 1 AND forma.cod_caseificio = caseificio.ID_Caseificio
GROUP BY
    forma.cod_caseificio
ORDER BY
    COUNT(forma.ID_Forma)
DESC
LIMIT 1;
/*
d) Visualizzare l’elenco dei caseifici che, in un certo periodo individuato da due date fornite dall’utente, hanno venduto meno di 10 forme di seconda scelta
*/
SELECT
    caseificio.Nome
FROM
    caseificio,
    forma
WHERE
    forma.cod_caseificio = caseificio.ID_Caseificio AND forma.Data_Produzione BETWEEN @oggi AND @domani AND forma.Scelta = 0
GROUP BY
    caseificio.ID_Caseificio
HAVING
    COUNT(forma.ID_Forma) < 10;