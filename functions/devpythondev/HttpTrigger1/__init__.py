import logging

import azure.functions as func
import json
from azure.identity import DefaultAzureCredential
from azure.mgmt.resource.resources import ResourceManagementClient
from azure.mgmt.advisor import AdvisorManagementClient
from azure.mgmt.security import SecurityCenter

def main(req: func.HttpRequest) -> func.HttpResponse:

    credential = DefaultAzureCredential()


    security = SecurityCenter(
        credential=credential,
        subscription_id="0f267853-703c-4468-89a5-276d92a0f3be"
    )

    client = ResourceManagementClient(
        credential=credential,
        subscription_id="0f267853-703c-4468-89a5-276d92a0f3be"
    )

    advisor = AdvisorManagementClient(
        credential=credential,
        subscription_id="0f267853-703c-4468-89a5-276d92a0f3be"
    )

    result = [object.serialize() for object in advisor.recommendations.list()]
    #result = [object.serialize() for object in client.resource_groups.list()]
    #result = [object.serialize() for object in security.alerts.list()]


    """ result = {'advisor' : [object.serialize() for object in advisor.recommendations.list()],
    'client' : [object.serialize() for object in client.resource_groups.list()],
    'security' : [object.serialize() for object in security.alerts.list()]} """


    return func.HttpResponse(
            json.dumps(result),
            status_code=200
    )
