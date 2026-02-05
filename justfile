new:
  #!/usr/bin/env bash
  NAME=$(gum input --placeholder "Enter presentation name")
  if [ -n "$NAME" ]; then
    mkdir -p "./org/$NAME/images"
    cp ./template.org "./org/$NAME/main.org"
    cp -r ./images "./org/$NAME"
    echo "Created new presentation: ./org/$NAME"
  else
    echo "Error: No presentation name provided"
    exit 1
  fi


build:
  #!/usr/bin/env bash
  NAME=$(fd . ./org/ --max-depth 1 | gum filter)
  if [ -n "$NAME" ]; then
    emacs --batch "$NAME/main.org" --eval '(org-babel-tangle)'
    typst compile "$NAME/main.typ" --root .
  else
    echo "Error: No presentation name provided"
    exit 1
  fi

watch:
  #!/usr/bin/env bash
  NAME=$(fd . ./org/ --max-depth 1 | gum filter)
  if [ -n "$NAME" ]; then
    typst watch "./$NAME/main.typ" --root .
  else
    echo "Error: No presentation name provided"
    exit 1
  fi
