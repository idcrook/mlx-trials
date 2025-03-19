
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

<https://huggingface.co/mlx-community>

### mlx community

`mlx-community/Mistral-7B-Instruct-v0.3-4bit`

```shell
# ERROR # mlx_lm.generate --model mlx-community/Mistral-7B-Instruct-v0.3-4bit --prompt "hello"
# ValueError: Cannot instantiate this tokenizer from a slow version. If it's based on sentencepiece, make sure you have sentencepiece installed.
#  pip install sentencepiece
```

yields

```
==========
Hello! How can I help you today? If you have any questions or need assistance with something, feel free to ask. I'm here to help.
==========
Prompt: 7 tokens, 23.787 tokens-per-sec
Generation: 33 tokens, 15.054 tokens-per-sec
Peak memory: 4.126 GB
```

`mlx-community/DeepSeek-R1-Distill-Qwen-7B-4bit`


<https://huggingface.co/mlx-community/DeepSeek-R1-Distill-Qwen-7B-4bit>


```
mlx_lm.generate --model mlx-community/DeepSeek-R1-Distill-Qwen-7B-4bit --prompt "hello"
```


```
==========
Okay, the user just said "hello." I should respond in a friendly and welcoming way. Maybe say something like, "Hello! How can I assist you today?" That should cover it and let them know I'm here to help.
</think>

Hello! How can I assist you today?
==========
Prompt: 6 tokens, 12.215 tokens-per-sec
Generation: 60 tokens, 14.596 tokens-per-sec
Peak memory: 4.316 GB
```



`mlx-community/DeepSeek-R1-Distill-Llama-8B-4bit`

<https://huggingface.co/mlx-community/DeepSeek-R1-Distill-Llama-8B-4bit>


```
mlx_lm.generate --model mlx-community/DeepSeek-R1-Distill-Llama-8B-4bit --prompt "hello"
```

yields

```
==========
Alright, the user said "hello." That's a friendly greeting. I should respond in a welcoming manner.

I want to make sure they feel comfortable asking for help. Maybe I can offer my assistance.

I should keep it open-ended so they know I'm here to help with whatever they need.

Let me make sure my response is warm and approachable.
</think>

Hello! How can I assist you today?
==========
Prompt: 6 tokens, 19.489 tokens-per-sec
Generation: 84 tokens, 13.541 tokens-per-sec
Peak memory: 4.564 GB
```

`mlx-community/DeepSeek-R1-Distill-Qwen-7B-8bit`

<https://huggingface.co/mlx-community/DeepSeek-R1-Distill-Qwen-7B-8bit>

```
mlx_lm.generate --model mlx-community/DeepSeek-R1-Distill-Qwen-7B-8bit --prompt "hello"
```

yields

```
==========
Alright, the user just said "hello." That's a friendly greeting. I should respond in a warm and welcoming manner. Maybe say something like, "Hello! How can I assist you today?" That should cover it and let them know I'm here to help.
</think>

Hello! How can I assist you today?
==========
Prompt: 6 tokens, 14.606 tokens-per-sec
Generation: 66 tokens, 7.833 tokens-per-sec
Peak memory: 8.119 GB
```

### llama 3.2 1B 4b

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
