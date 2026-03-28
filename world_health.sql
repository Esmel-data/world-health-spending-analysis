-- Reveals how countries distribute across spending levels
-- Decision : identify which spending tier dominates globally

SELECT
    health_spending_category,
    COUNT(DISTINCT country)                         AS nb_countries,
    ROUND(AVG(health_spending_pct_gdp), 2)          AS avg_spending_pct_gdp
FROM world_health
WHERE health_spending_pct_gdp IS NOT NULL
GROUP BY health_spending_category
ORDER BY avg_spending_pct_gdp DESC;

-- Reveals countries with the worst health outcome on most recent data
-- Decision : priority targets for international health investment

SELECT
    country,
    country_code,
    year,
    life_expectancy_years,
    life_expectancy_category,
    health_spending_category
FROM world_health
WHERE year = (SELECT MAX(year) FROM world_health_data_clean)
ORDER BY life_expectancy_years ASC
LIMIT 10;

-- Reveals efficient countries : high output with limited resources
-- Decision : identify best practice models to replicate

SELECT
    country,
    country_code,
    health_spending_category,
    ROUND(AVG(health_spending_pct_gdp), 2)  AS avg_spending,
    ROUND(AVG(life_expectancy_years), 1)    AS avg_life_expectancy,
    ROUND(AVG(health_roi_score), 2)         AS avg_roi_score
FROM world_health
WHERE health_spending_category IN ('Low', 'Medium')
    AND health_roi_score IS NOT NULL
GROUP BY country, country_code, health_spending_category
ORDER BY avg_roi_score DESC
LIMIT 15;

-- Reveals double-burden countries facing both mortality and infectious disease pressure
-- Decision : highest priority for multi-axis health intervention

SELECT
    country,
    country_code,
    ROUND(AVG(avoidable_mortality_index), 3)    AS avg_mortality_index,
    ROUND(AVG(infectious_disease_index), 3)     AS avg_infectious_index,
    health_spending_category
FROM world_health
WHERE avoidable_mortality_index > 0.6
    AND infectious_disease_index > 0.6
GROUP BY country, country_code, health_spending_category
ORDER BY avg_mortality_index DESC, avg_infectious_index DESC;


-- Reveals countries where high spending does not translate into health outcomes
-- Decision : investigate structural inefficiencies or misallocation of health budget

SELECT
    country,
    country_code,
    year,
    health_spending_pct_gdp,
    life_expectancy_years,
    life_expectancy_category,
    health_roi_score,
    performance_gap_flag
FROM world_health
WHERE performance_gap_flag = 'Critical Gap'
ORDER BY health_roi_score ASC;

-- Reveals country ranking on avoidable mortality on most recent data
-- Decision : identify where preventable deaths are most concentrated

SELECT
    country,
    country_code,
    ROUND(avoidable_mortality_index, 3)     AS mortality_index,
    life_expectancy_years,
    health_spending_category
FROM world_health
WHERE year = (SELECT MAX(year) FROM world_health_data_clean)
    AND avoidable_mortality_index IS NOT NULL
ORDER BY avoidable_mortality_index DESC
LIMIT 20;

-- Reveals whether higher spending effectively reduces infectious disease burden
-- Decision : validate the spending → disease control hypothesis

SELECT
    health_spending_category,
    COUNT(DISTINCT country)                         AS nb_countries,
    ROUND(AVG(infectious_disease_index), 3)         AS avg_infectious_index,
    ROUND(MIN(infectious_disease_index), 3)         AS best_control,
    ROUND(MAX(infectious_disease_index), 3)         AS worst_control
FROM world_health
WHERE health_spending_category IS NOT NULL
    AND infectious_disease_index IS NOT NULL
GROUP BY health_spending_category
ORDER BY avg_infectious_index ASC;

-- Reveals the descriptive relationship between spending and life expectancy across all countries
-- Decision : global positioning map — input for scatter plot in Power BI

SELECT
    country,
    country_code,
    health_spending_category,
    life_expectancy_category,
    ROUND(AVG(health_spending_pct_gdp), 2)  AS avg_spending,
    ROUND(AVG(life_expectancy_years), 1)    AS avg_life_expectancy,
    ROUND(AVG(health_roi_score), 2)         AS avg_roi_score,
    ROUND(AVG(avoidable_mortality_index),3) AS avg_mortality_index,
    ROUND(AVG(infectious_disease_index),3)  AS avg_infectious_index
FROM world_health
WHERE health_spending_pct_gdp IS NOT NULL
    AND life_expectancy_years IS NOT NULL
GROUP BY
    country,
    country_code,
    health_spending_category,
    life_expectancy_category
ORDER BY avg_life_expectancy DESC;
