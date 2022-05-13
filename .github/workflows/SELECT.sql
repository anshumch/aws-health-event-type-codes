SELECT
	linked_account_id "account"
	,service
	,sum(amortized_cost) amortized_cost
        FROM summary_view
        WHERE year = '2022' AND month IN ('01', '02', '03', '04')
        AND service = 'AmazonGuardDuty'
        AND amortized_cost = 0
        AND linked_account_id IN(
SELECT linked_account_id FROM
    (SELECT
	linked_account_id
	,sum(amortized_cost) amortized_cost
        FROM summary_view
        WHERE year = '2022' AND month IN ('01', '02', '03', '04')
        AND service = 'AmazonEKS'
        AND amortized_cost > 0
        GROUP BY 1))
GROUP BY 1, 2