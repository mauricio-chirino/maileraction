for sub in schedule; do
  for lang in es en fr pt de it; do
    echo "$lang: {}" > $sub/$lang.yml
  done
done
