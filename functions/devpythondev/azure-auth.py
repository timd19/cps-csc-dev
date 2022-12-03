from azure.identity import DefaultAzureCredential
from azure.mgmt.resource.resources import ResourceManagementClient
from azure.mgmt.advisor import AdvisorManagementClient
from azure.mgmt.security import SecurityCenter


credential = DefaultAzureCredential()
scope = "https://management.azure.com/.default"


security = SecurityCenter(
    credential=credential,
    subscription_id="0f267853-703c-4468-89a5-276d92a0f3be"
)

for score in security.secure_scores.list():
    print({score.percentage})

"""
print(f"secure scores: {security.secure_scores.get(secure_score_name='acsScore')}")
"""
""" advisor = AdvisorManagementClient(
    credential=credential,
    subscription_id="0f267853-703c-4468-89a5-276d92a0f3be"
)

for recommendation in advisor.recommendations.list():
    print(f"Advisor Recommendation: {recommendation.impact}")



client = ResourceManagementClient(
    credential=credential,
    subscription_id="0f267853-703c-4468-89a5-276d92a0f3be"
)

for resource_group in client.resource_groups.list():
    resource_group(item)

print(f"Successful credential: {credential}")
 """