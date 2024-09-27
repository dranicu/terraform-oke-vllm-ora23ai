ingress:
  enabled: true

deploy:
  env:
    - name: HF_TOKEN
      value: ${HF_TOKEN}
  extraArgs:
    - "--model"
    - "${model}"
    %{ if max_model_len != "-1" }
    - "--max-model-len"
    - "${max_model_len}"
    %{ endif }
    - "--api-key"
    - "${LLM_API_KEY}"
    - "--chat-template=/chat-templates/gemma-it.jinja"

  image:
    tag: "latest"

  pvcCache:
    enabled: true

  volumeMounts:
    - name: chat-template-volume
      mountPath: /chat-templates

  volumes:
    - name: chat-template-volume
      configMap:
        name: chat-template-config