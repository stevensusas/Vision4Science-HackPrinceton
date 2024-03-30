import os
import re
import json
import ast
from openai import OpenAI
from dotenv import load_dotenv
import numpy as np
from scipy.spatial.distance import cosine

def get_embedding(client, text, model="text-embedding-3-large"):
    return client.embeddings.create(input=text, model=model).data[0].embedding

def find_similar_reagents(client, gene_reagents):
    actual_reagents = ['pipet', 'cultural disk', 'chemical reagents', 'beaker', 'erlenmeyer flask']
    gene_reagents = [reagent.lower() for reagent in gene_reagents]

    gene_reagents_embeddings = [get_embedding(client, reagent) for reagent in gene_reagents]
    # print(gene_reagents_embeddings[0])
    # print(type(gene_reagents_embeddings[0]))
    actual_reagents_embeddings = [get_embedding(client, reagent) for reagent in actual_reagents]

    gene_similar_actual_reagents = {}

    for i, gene_reagent in enumerate(gene_reagents):
        max_similarity = -1
        for j, actual_reagent in enumerate(actual_reagents):
            similarity = 1 - cosine(gene_reagents_embeddings[i], actual_reagents_embeddings[j])
            if similarity > max_similarity:
                max_similarity = similarity
                gene_similar_actual_reagents[gene_reagent] = actual_reagent

    return gene_similar_actual_reagents


def process_sequential_protocol(protocol):
    load_dotenv()

    client = OpenAI(
      api_key=os.environ.get('mykey')
    )

    max_attempts = 10
    attempt = 0
    success = False
    data = {"error": "Failed to process the protocol after multiple attempts."}

    while not success and attempt < max_attempts:
        # print("ATTEMPT: ", attempt)
        try:
            completion = client.chat.completions.create(
              model="gpt-4-0125-preview",
              messages=[
                {"role": "user", "content": "Identify the key steps and reagents/objects used in this biological experiment procedure, and generate two python arrays that store respectively strings describing the key steps and another python array that stores the reagents/objects " + protocol},
              ],
            )

            message = completion.choices[0].message.content
            # print("MESSAGE: ", message)  # Optional: For debugging purposes
            # print(message)  # Optional: For debugging purposes

            steps_match = re.search(r'steps = (\[.*?\])', message, re.DOTALL)
            reagents_objects_match = re.search(r'reagents_objects = (\[.*?\])', message, re.DOTALL)

            if steps_match and reagents_objects_match:
                steps_array = ast.literal_eval(steps_match.group(1))
                reagents_objects_array = ast.literal_eval(reagents_objects_match.group(1))
                reagents_objects_array = find_similar_reagents(OpenAI(api_key='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'), reagents_objects_array)
                data = {"steps": steps_array, "reagents_objects": reagents_objects_array}
                success = True
                return json.dumps(data)
            else:
                attempt += 1
                # print(f"Attempt {attempt}: Failed to find matches. Retrying...")  # Optional: For debugging purposes
        except Exception as e:
            attempt += 1
            # print(f"Attempt {attempt}: Error occurred - {str(e)}. Retrying...")  # Optional: For debugging purposes
    return json.dumps(data)

if __name__ == "__main__":
    import sys
    protocol = " ".join(sys.argv[1:])
    print(process_sequential_protocol(protocol))


