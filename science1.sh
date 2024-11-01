#!/bin/bash

# Enable case-insensitive pattern matching
shopt -s nocasematch

ask_question() {
  local level=$1
  local questions
  local correct_answer
  local user_answer

  # Define questions and answers for each level
  declare -A level1_questions=(
    ["What planet is known as the Red Planet?"]="Mars"
    ["What is the chemical symbol for water?"]="H2O"
    ["What gas do plants absorb from the atmosphere?"]="Carbon dioxide"
    ["What force keeps us on the ground?"]="Gravity"
    ["What is the center of an atom called?"]="Nucleus"
  )

  declare -A level2_questions=(
    ["What is the hardest natural substance on Earth?"]="Diamond"
    ["What is the process by which plants make their food?"]="Photosynthesis"
    ["What is the main gas found in the air we breathe?"]="Nitrogen"
    ["What organ pumps blood through the body?"]="Heart"
    ["What part of the cell contains the genetic material?"]="Nucleus"
  )

  declare -A level3_questions=(
    ["What is the most abundant gas in Earth's atmosphere?"]="Nitrogen"
    ["Who developed the theory of general relativity?"]="Albert Einstein"
    ["What is the chemical formula for table salt?"]="NaCl"
    ["What type of celestial body is the sun?"]="Star"
    ["What is the smallest particle of an element?"]="Atom"
  )

  declare -A level4_questions=(
    ["What is the powerhouse of the cell?"]="Mitochondria"
    ["What is the most reactive element?"]="Fluorine"
    ["What is the speed of light in a vacuum?"]="299,792,458 meters per second"
    ["Who is known as the father of modern chemistry?"]="Antoine Lavoisier"
    ["What is the second most abundant element in the Earth's crust?"]="Silicon"
  )

  # Assign questions and answers based on the level chosen
  case $level in
    1) questions=("${!level1_questions[@]}"); declare -n questions_by_level="level1_questions" ;;
    2) questions=("${!level2_questions[@]}"); declare -n questions_by_level="level2_questions" ;;
    3) questions=("${!level3_questions[@]}"); declare -n questions_by_level="level3_questions" ;;
    4) questions=("${!level4_questions[@]}"); declare -n questions_by_level="level4_questions" ;;
    *)
      echo "Invalid level."
      return 1
      ;;
  esac

  for question in "${questions[@]}"; do
    correct_answer="${questions_by_level[$question]}"

    read -r -p "Question: $question " user_answer

    if [[ "$user_answer" == "$correct_answer" ]]; then
      echo "Correct! Well done!"
    else
      echo "Incorrect. The correct answer is '$correct_answer'."
    fi
  done

  return 0
}

main() {
  echo "Welcome to the science quiz!"
  echo "Please pick a level:"
  echo "1. Beginner"
  echo "2. Intermediate"
  echo "3. Advanced"
  echo "4. Expert"

  read -r -p "Enter the level number you want to attempt: " level
  level=$(echo "$level" | xargs)  # Trim whitespace

  # Debugging output
  echo "You entered: '$level'"  # Show what was entered
  echo "Length of input: ${#level}"  # Show length of input for troubleshooting

  case $level in
    1|2|3|4)
      echo -e "\nYou have chosen Level $level. You will be asked 5 questions."
      ask_question "$level"
      ;;
    one|two|three|four)
      # Convert text input to corresponding level number
      if [[ "$level" == "one" ]]; then level=1; fi
      if [[ "$level" == "two" ]]; then level=2; fi
      if [[ "$level" == "three" ]]; then level=3; fi
      if [[ "$level" == "four" ]]; then level=4; fi
      echo -e "\nYou have chosen Level $level. You will be asked 5 questions."
      ask_question "$level"
      ;;
    *)
      echo "Invalid level selected. Exiting."
      ;;
  esac

  echo -e "\nQuiz made by LearnMoreStuff and CloIT."
}

main
