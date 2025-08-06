# some newer trials


## server

for karakeep inference

      OPENAI_BASE_URL: "http://192.168.50.7:11434/v1"
      OPENAI_API_KEY: "nokey"

```text
mlx_lm.server --model mlx-community/gemma-3-4b-it-8bit --port 11434 --host 192.168.50.7
```

similar

```
curl http://192.168.50.7:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
     "messages": [{"role": "user", "content": "Say this is a test!"}],
     "temperature": 0.7
   }'
```

## gemma3 variations
c. August 2025

### gemma3 12b

```
mlx_lm.generate --model mlx-community/gemma3-12b-it-4bit-DWQ --prompt "hello"

Peak memory: 7.320 GB
```

### google/gemma-3-4b-it

```shell
❯ huggingface-cli login
❯ mlx_lm.generate --model google/gemma-3-4b-it --prompt "hello"

Peak memory: 8.041 GB
```

### mlx-community/gemma-3-4b-it-4bit-DWQ (text)

```shell
❯ mlx_lm.generate --model mlx-community/gemma-3-4b-it-4bit-DWQ --prompt "hello"
Prompt: 10 tokens, 14.259 tokens-per-sec
Generation: 48 tokens, 20.689 tokens-per-sec
Peak memory: 2.613 GB
```

### mlx-community/gemma-3-4b-it-4bit

```shell
❯ mlx_lm.generate --model mlx-community/gemma-3-4b-it-4bit  --prompt "hello"
Prompt: 10 tokens, 16.007 tokens-per-sec
Generation: 67 tokens, 22.391 tokens-per-sec
Peak memory: 2.613 GB
```

### mlx-community/gemma-3-4b-it-abliterated-8bit-text

```
mlx_lm.generate --model mlx-community/gemma-3-4b-it-abliterated-8bit-text  --prompt "hello"
==========
Prompt: 10 tokens, 5.968 tokens-per-sec
Generation: 67 tokens, 11.950 tokens-per-sec
Peak memory: 4.889 GB
```

### mlx-community/gemma-3-4b-it-8bit (visual)

```
mlx_lm.generate --model  mlx-community/gemma-3-4b-it-8bit  --prompt "hello"
Prompt: 10 tokens, 8.925 tokens-per-sec
Generation: 24 tokens, 12.443 tokens-per-sec
Peak memory: 4.888 GB
```

## server

for karakeep inference

      OPENAI_BASE_URL: "http://192.168.50.7:11434/v1"
      OPENAI_API_KEY: "nokey"

```text
mlx_lm.server --model mlx-community/gemma-3-4b-it-8bit --port 11434 --host 192.168.50.7
```

similar

```
curl http://192.168.50.7:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
     "messages": [{"role": "user", "content": "Say this is a test!"}],
     "temperature": 0.7
   }'
```

### other attempts

these did not pan out

#### llm-mlx

**Does not have server API**

https://simonwillison.net/2025/Feb/15/llm-mlx/
 - https://llm.datasette.io/en/stable/setup.html

https://kconner.com/2025/02/17/running-local-llms-with-mlx.html

in conda env

```
conda install -c conda-forge llm

# plugin
llm install llm-mlx

# copy over mlx-lm models
llm mlx manage-models

```

#### mlx-llm-server

**Does not work with gemma3** (support is missing)

https://pypi.org/project/mlx-llm-server/

https://github.com/mzbac/mlx-llm-server

```
conda create -n mlx-llm python=3.10
conda activate mlx-llm
conda_enter mlx-llm

pip install mlx-llm-server

mlx-llm-server --model <path-to-your-model>

mlx-llm-server --model ""
```


#### mlx-openai-server

**SERVER API NOT WORKING WITH KARAKEEP**

need to try ` --model-type lm `

https://github.com/cubist38/mlx-openai-server

```
conda create -n mlx-server python=3.11 -y
conda activate mlx-server
conda_enter mlx-server

pip install mlx-openai-server

mlx-openai-server --version
mlx-openai-server launch --help

mlx-openai-server launch \
  --model-path  mlx-community/gemma-3-4b-it-8bit \
  --model-type multimodal \
  --max-concurrency 1 \
  --queue-timeout 300 \
  --queue-size 100 \
  --port 11434 \
  --host 192.168.50.7

```
