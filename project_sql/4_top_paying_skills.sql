SELECT 
    skills,
    ROUND(AVG(salary_year_avg),1) AS avg_salary,
    COUNT(*) AS skill_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim
ON
    skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
    skills_dim
ON
    skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
AND 
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*

Overview
Highest Paying Skill: The skill with the highest average salary is SVN at $400,000. This is significantly higher than all other listed skills, indicating that it may be a specialized or high-demand area.
Mid-Range Skills: Skills like Solidity ($179,000) and Couchbase ($160,515) are in the upper mid-range, suggesting they are valuable in specific sectors such as blockchain and database management.
General Trend: Most skills fall within the $120,000 to $160,000 range, indicating a healthy market for those skill sets.
Key Insights
Emerging Technologies: Skills related to blockchain (Solidity) and machine learning (Keras, PyTorch, TensorFlow) are prominently featured, highlighting the demand for expertise in these areas.
DevOps and Automation Tools: Skills like Terraform, Ansible, and VMware reflect a strong demand for infrastructure and automation knowledge, crucial for modern software development and deployment.
Data Management: Skills associated with data manipulation and databases (Dplyr, Cassandra, Couchbase) are also valuable, indicating a trend towards data-centric roles.
Language Diversity: The list includes a variety of programming languages (e.g., Go, Scala, Perl), underscoring the need for versatility among developers.
Recommendations
Skill Development: Consider focusing on high-demand skills like Solidity and data manipulation tools if you’re looking to boost your earning potential.
Certification and Training: Pursuing certifications in areas like DevOps, cloud technologies, or machine learning could enhance job prospects and salary.
Market Trends: Stay updated on market trends, as the tech landscape evolves rapidly, affecting the demand for specific skills.
This data provides a clear picture of current industry standards for compensation based on skills, useful for career planning or recruitment strategies.

*/