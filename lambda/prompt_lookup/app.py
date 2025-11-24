import os
import json
import boto3

ddb = boto3.resource("dynamodb")
table = ddb.Table(os.environ["PROMPTS_TABLE"])

def lambda_handler(event, context):
    # Connect usually passes attributes under Details/Parameters,
    # but we’ll allow simple test calls too.
    key = (
        event.get("PromptKey")
        or event.get("prompt_key")
        or event.get("Details", {}).get("Parameters", {}).get("PromptKey")
    )

    if not key:
        return {"error": "PromptKey required"}

    resp = table.get_item(Key={"PromptKey": key})
    item = resp.get("Item")

    if not item:
        return {"error": f"PromptKey {key} not found"}

    return item
