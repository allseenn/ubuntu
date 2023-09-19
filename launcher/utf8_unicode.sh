!/bin/bash
xclip -o -selection clipboard | python -c "import sys; print(sys.stdin.read().encode('unicode_escape').decode())" | xclip -selection clipboard

