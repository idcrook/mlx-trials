
# mlx-lm

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

## manage models


```
mlx_lm.manage --scan
mlx_lm.manage --delete --pattern DeepSeek-R1-Distill-Qwen-32B-4bit
```

```
Scanning Hugging Face cache for models with pattern "mlx".
REPO ID                                         REPO TYPE SIZE ON DISK NB FILES LAST_ACCESSED     LAST_MODIFIED  LOCAL PATH
----------------------------------------------- --------- ------------ -------- ----------------- -------------- ------------------------------------------------------------------------------------------
mlx-community/DeepSeek-R1-Distill-Qwen-32B-4bit model            18.4G        9 6 minutes ago     6 minutes ago  $HOME/.cache/huggingface/hub/models--mlx-community--DeepSeek-R1-Distill-Qwen-32B-4bit
```

## hugging face

<https://huggingface.co/mlx-community>

### mlx community

#### `mlx-community/Mistral-7B-Instruct-v0.3-4bit`

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

#### `mlx-community/DeepSeek-R1-Distill-Qwen-7B-4bit`


<https://huggingface.co/mlx-community/DeepSeek-R1-Distill-Qwen-7B-4bit>


```
mlx_lm.generate --model mlx-community/DeepSeek-R1-Distill-Qwen-7B-4bit --prompt "hello"
```

yields

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



####  `mlx-community/DeepSeek-R1-Distill-Llama-8B-4bit`

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

####  `mlx-community/DeepSeek-R1-Distill-Qwen-7B-8bit`

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

#### `mlx-community/DeepSeek-R1-Distill-Qwen-14B-4bit`

https://huggingface.co/mlx-community/DeepSeek-R1-Distill-Qwen-14B-4bit

```shell
mlx_lm.generate --model mlx-community/DeepSeek-R1-Distill-Qwen-14B-4bit --prompt "hello"
```

yields

```
Alright, the user said "hello". That's a friendly greeting. I should respond in a welcoming manner

I want to make sure they feel comfortable asking for help. Maybe I'll ask how I can assist them today.

Keeping it open-ended so they can specify what they need.
</think>

Hello! How can I assist you today?
==========
Prompt: 6 tokens, 9.154 tokens-per-sec
Generation: 69 tokens, 7.041 tokens-per-sec
Peak memory: 8.372 GB
```

#### `mlx-community/DeepSeek-R1-Distill-Qwen-14B-3bit`


```
mlx_lm.generate --model mlx-community/DeepSeek-R1-Distill-Qwen-14B-3bit --prompt "hello"
```

## TOO BIG

- `mlx-community/DeepSeek-R1-Distill-Qwen-32B-4bit` hangs system on 16GB RAM M1 Mac mini

#### `mlx-community/DeepSeek-R1-Distill-Qwen-32B-3bit`

```
mlx_lm.generate --model mlx-community/DeepSeek-R1-Distill-Qwen-32B-3bit --prompt "hello"
```

```
[WARNING] Generating with a model that requires 13671 MB which is close to the maximum recommended size of 10922 MB. This can be slow. See the documentation for possible work-arounds: https://github.com/ml-explore/mlx-lm/tree/main#large-models
```

try workaround

```
sudo sysctl iogpu.wired_limit_mb=14000

iogpu.wired_limit_mb: 0 -> 14000
```

still hangs


### fast!

llama 3.2 1B 4b

<https://huggingface.co/mlx-community/Llama-3.2-1B-Instruct-4bit>


```python
from mlx_lm import load, generate

model, tokenizer = load("mlx-community/Llama-3.2-1B-Instruct-4bit`w")

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


#### `mlx-community/Llama-3.2-3B-Instruct-4bit`

```
mlx_lm.generate --model mlx-community/Llama-3.2-3B-Instruct-4bit --prompt "hello"
```

yields

```
==========
Hello! It's nice to meet you. Is there something I can help you with or would you like to chat?
==========
Prompt: 36 tokens, 132.430 tokens-per-sec
Generation: 25 tokens, 28.813 tokens-per-sec
Peak memory: 1.905 GB
```
