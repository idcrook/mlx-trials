
# mpl-lm

<https://github.com/ml-explore/mlx-lm>

```
#conda create -n py39-mlx python=3.9 -y
#conda install -c conda-forge mlx-lm
conda create -n py312-mlx python=3.12 -y
conda activate py312-mlx
conda_enter py312-mlx
conda install -c conda-forge mlx-lm

# workaround for error
# Exception: data did not match any variant of untagged enum ModelWrapper at line 1251003 column 3
pip3 install transformers==4.45.2
```


??? : `pip3 install unsloth==2024.10.4 torch==2.4.1`

## hugging face

<https://huggingface.co/mlx-community/Llama-3.2-1B-Instruct-4bit>


```python
from mlx_lm import load, generate

model, tokenizer = load("mlx-community/Llama-3.2-1B-Instruct-4bit")

prompt = "hello"

if tokenizer.chat_template is not None:
    messages = [{"role": "user", "content": prompt}]
    prompt = tokenizer.apply_chat_template(
        messages, add_generation_prompt=True
    )

response = generate(model, tokenizer, prompt=prompt, verbose=True)
```

can run from env

```
python chat.py

Fetching 6 files: ...
==========
Hello! How can I help you today?
==========
Prompt: 36 tokens, 338.614 tokens-per-sec
Generation: 10 tokens, 83.337 tokens-per-sec
Peak memory: 0.754 GB
```
