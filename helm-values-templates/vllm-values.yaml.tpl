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
    %{ if use_chat_template == true }
    - "--chat-template=/chat-templates/chat-template.jinja"
    %{ endif }

  image:
    tag: "latest"

  pvcCache:
    enabled: true

  volumeMounts:
    %{ if use_chat_template == true }
    - name: chat-template-volume
      mountPath: /chat-templates
    %{ endif }

  volumes:
    %{ if use_chat_template == true }
    - name: chat-template-volume
      configMap:
        name: chat-template-config
    %{ endif }
