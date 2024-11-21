Curlduck
========

A simple curl+jq shell script to ask questions to [Duckduckgo AIChat
LLMs](https://duckduckgo.com/aichat) (Llama3, etc...).

Usage
=====

```
$ ./curlduck.sh "question"
```

Example:

```
$ ./curlduck.sh "What is the surface area of the earth in square kilometers?"
The surface area of the Earth is approximately 510,065,600 square kilometers.
```

Dependencies
============

curl grep awk sed tr

Todo
====

* ~~add a usage example if argument is not provided~~
* ~~add a check_commands if 'curl grep awk sed jq tr' are not installed~~
* ~~replace JQ by awk or sed equivalent~~
* add an option to specify another model (llama3, gpt4o, mixtral, claude3)

Links
=====

* https://duckduckgo.com/aichat
* https://blek.codes/blog/duckduckgo-ai-chat/
* https://medium.com/@Jackiesogi/%E5%85%A9%E5%80%8B%E5%85%8D%E8%B2%BB%E4%B8%94%E5%BC%B7%E5%A4%A7%E7%9A%84%E5%A4%A7%E5%9E%8B%E8%AA%9E%E8%A8%80%E6%A8%A1%E5%9E%8B-api-%E6%9C%8D%E5%8B%99-2636a6f5bdb8
* https://github.com/SixArm/curl-chatgpt
* https://github.com/benoitpetit/duckduckGO-chat-cli
* https://github.com/HuggingBear/DuckDuckGo-AI
