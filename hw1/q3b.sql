--3b (5 points). Find the top five zip codes with most pills sold in terms of MME when normalized by the population in the zip codes, i.e., zip codes with most sold total MME of pills per person

SELECT ZIPPOP_ZIP, NORMALIZED,MME_SUM, RANK() over (ORDER BY NORMALIZED DESC)
AS RANK FROM(SELECT ZIPPOP.ZIP AS ZIPPOP_ZIP,DEA_NY.MME_SUM AS MME_SUM, (DEA_NY.MME_SUM/ZIPPOP.ZPOP)
AS NORMALIZED FROM CSE532.ZIPPOP ZIPPOP
INNER JOIN
(SELECT DNY.BUYER_ZIP AS ZIP_CODE, SUM(MME) AS MME_SUM
FROM CSE532.DEA_NY DNY
    INNER JOIN  CSE532.ZIPPOP ZP ON DNY.BUYER_ZIP = ZP.ZIP
    GROUP BY DNY.BUYER_ZIP) DEA_NY ON ZIPPOP.ZIP = DEA_NY.ZIP_CODE
    WHERE ZIPPOP.ZPOP != 0)
FETCH FIRST 5 ROWS ONLY;