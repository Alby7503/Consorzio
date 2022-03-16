-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mar 16, 2022 alle 23:04
-- Versione del server: 10.4.21-MariaDB
-- Versione PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `consorzio`
--

DELIMITER $$
--
-- Procedure
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `c` (OUT `result` INT)  READS SQL DATA
BEGIN
    DECLARE nothing INT;
SELECT
    forma.cod_caseificio,
    COUNT(forma.ID_Forma) AS SOMMA
INTO
    result,
    nothing
FROM
    forma,
    caseificio
WHERE
    forma.Scelta = TRUE AND forma.cod_caseificio = caseificio.ID_Caseificio
GROUP BY
    forma.cod_caseificio
ORDER BY
    SOMMA DESC
LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `co` (OUT `result` INT)  READS SQL DATA
BEGIN
    DECLARE nothing INT;
SELECT
    forma.cod_caseificio,
    COUNT(forma.ID_Forma) AS SOMMA
INTO
    result,
    nothing
FROM
    forma,
    caseificio
WHERE
    forma.Scelta = TRUE AND forma.cod_caseificio = caseificio.ID_Caseificio
GROUP BY
    forma.cod_caseificio
ORDER BY
    SOMMA DESC
LIMIT 1;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `caseificio`
--

CREATE TABLE `caseificio` (
  `ID_Caseificio` int(11) NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `Indirizzo` varchar(50) NOT NULL,
  `Provincia` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `caseificio`
--

INSERT INTO `caseificio` (`ID_Caseificio`, `Nome`, `Indirizzo`, `Provincia`) VALUES
(1, 'Centrale del latte', 'Via Roma 42', 'RM'),
(2, 'Ritrovo appassionati latte', 'Via Napoli 2', 'NA');

-- --------------------------------------------------------

--
-- Struttura della tabella `forma`
--

CREATE TABLE `forma` (
  `ID_Forma` int(11) NOT NULL,
  `cod_caseificio` int(11) NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `Stagionatura` int(11) NOT NULL,
  `Tipo_Acquirente` varchar(50) NOT NULL,
  `Scelta` tinyint(1) NOT NULL,
  `Data_Produzione` date NOT NULL DEFAULT current_timestamp(),
  `Numero_Progressivo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `forma`
--

INSERT INTO `forma` (`ID_Forma`, `cod_caseificio`, `Nome`, `Stagionatura`, `Tipo_Acquirente`, `Scelta`, `Data_Produzione`, `Numero_Progressivo`) VALUES
(1, 1, 'Formaggione', 12, 'Privato', 1, '2022-03-09', NULL),
(2, 2, 'Formaggino', 24, 'Azienda', 0, '2022-03-09', NULL),
(3, 1, 'Formaggetto', 6, 'Privato', 0, '2022-03-09', NULL),
(4, 1, 'Formaggio Oro', 3, 'Azienda', 0, '2022-03-09', NULL),
(5, 2, 'Formaggio Pregiato', 48, 'Privato', 1, '2022-03-09', NULL),
(6, 2, 'Formaggio Cosato', 96, 'Privato', 1, '2022-03-09', NULL),
(7, 1, 'Formaggio wasd', 24, 'Privato', 1, '2022-03-09', NULL),
(8, 1, 'Formaggio buono', 18, 'Azienda', 1, '2022-03-09', NULL),
(9, 2, 'Formaggio del potere', 2, 'Azienda', 1, '2022-03-09', NULL),
(10, 2, 'Formaggio divino', 1, 'Azienda', 1, '2022-03-09', NULL),
(11, 1, 'Formaggio non mi vengono più nomi', 8, 'Privato', 1, '2022-03-09', NULL),
(12, 1, 'Formaggio aia', 10, 'Privato', 1, '2022-03-09', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `luoghi_produzione`
--

CREATE TABLE `luoghi_produzione` (
  `ID_LP` int(11) NOT NULL,
  `cod_titolare` int(11) NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `indirizzo` varchar(50) NOT NULL,
  `Geolocalizzazione` point DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `luoghi_produzione`
--

INSERT INTO `luoghi_produzione` (`ID_LP`, `cod_titolare`, `Nome`, `indirizzo`, `Geolocalizzazione`) VALUES
(3, 1, 'Lattaio di casa', 'Via Foo 55', NULL),
(4, 1, 'Latteria professionale', 'Via Bar 78', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `persona`
--

CREATE TABLE `persona` (
  `ID_Persona` int(11) NOT NULL,
  `Nome` varchar(50) NOT NULL,
  `Cognome` varchar(50) NOT NULL,
  `Email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `persona`
--

INSERT INTO `persona` (`ID_Persona`, `Nome`, `Cognome`, `Email`) VALUES
(1, 'Mario', 'Rossi', 'mario.rossi@email.com');

-- --------------------------------------------------------

--
-- Struttura della tabella `utilizzo`
--

CREATE TABLE `utilizzo` (
  `ID_Utilizzo` int(11) NOT NULL,
  `cod_caseificio` int(11) NOT NULL,
  `Data` date NOT NULL DEFAULT current_timestamp(),
  `Latte_Lavorato` int(11) NOT NULL,
  `Latte_Produzione` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `utilizzo`
--

INSERT INTO `utilizzo` (`ID_Utilizzo`, `cod_caseificio`, `Data`, `Latte_Lavorato`, `Latte_Produzione`) VALUES
(1, 1, '2022-03-09', 500, 100),
(2, 2, '2022-03-09', 70, 20),
(3, 1, '2022-03-09', 700, 200);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `caseificio`
--
ALTER TABLE `caseificio`
  ADD PRIMARY KEY (`ID_Caseificio`);

--
-- Indici per le tabelle `forma`
--
ALTER TABLE `forma`
  ADD PRIMARY KEY (`ID_Forma`),
  ADD KEY `Forma <-> Caseificio` (`cod_caseificio`);

--
-- Indici per le tabelle `luoghi_produzione`
--
ALTER TABLE `luoghi_produzione`
  ADD PRIMARY KEY (`ID_LP`),
  ADD KEY `Luoghi_Produzione <-> Persona` (`cod_titolare`);

--
-- Indici per le tabelle `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`ID_Persona`);

--
-- Indici per le tabelle `utilizzo`
--
ALTER TABLE `utilizzo`
  ADD PRIMARY KEY (`ID_Utilizzo`),
  ADD KEY `Utilizzo <-> Caseificio` (`cod_caseificio`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `caseificio`
--
ALTER TABLE `caseificio`
  MODIFY `ID_Caseificio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la tabella `forma`
--
ALTER TABLE `forma`
  MODIFY `ID_Forma` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT per la tabella `luoghi_produzione`
--
ALTER TABLE `luoghi_produzione`
  MODIFY `ID_LP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `persona`
--
ALTER TABLE `persona`
  MODIFY `ID_Persona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT per la tabella `utilizzo`
--
ALTER TABLE `utilizzo`
  MODIFY `ID_Utilizzo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `forma`
--
ALTER TABLE `forma`
  ADD CONSTRAINT `Forma <-> Caseificio` FOREIGN KEY (`cod_caseificio`) REFERENCES `caseificio` (`ID_Caseificio`);

--
-- Limiti per la tabella `luoghi_produzione`
--
ALTER TABLE `luoghi_produzione`
  ADD CONSTRAINT `Luoghi_Produzione <-> Persona` FOREIGN KEY (`cod_titolare`) REFERENCES `persona` (`ID_Persona`);

--
-- Limiti per la tabella `utilizzo`
--
ALTER TABLE `utilizzo`
  ADD CONSTRAINT `Utilizzo <-> Caseificio` FOREIGN KEY (`cod_caseificio`) REFERENCES `caseificio` (`ID_Caseificio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
