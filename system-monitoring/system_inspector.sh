#!/bin/bash

#!/bin/bash

output=""
disk=false
mem=false

# 1. Parsing opzioni
while getopts "mdl:h" opt; do
    case "${opt}" in
        m) mem=true ;;          # Flag semplice -> impostiamo a true
        d) disk=true ;;         # Flag semplice -> impostiamo a true
        l) output="$OPTARG" ;;  # Prende il percorso del file
        h) 
            echo "[HELP] USAGE: $0 [-m] [-d] [-l output_file.txt]"
            exit 0
            ;;
        ?) 
            echo "[WARNING] INVALID ARGUMENT"
            exit 1 
            ;;
    esac
done

shift $((OPTIND - 1))

# 2. Fail-Fast (Errore se ENTRAMBI sono vuoti/false)
if [[ "$mem" == false && "$disk" == false ]]; then
    echo "[ERROR] Devi specificare almeno -m oppure -d!"
    exit 1
fi

# 3. Funzioni
check_memory() {
    echo "--- MEMORIA RAM ---"
    free -h | grep "Mem:"
}

check_disk() {
    echo "--- SPAZIO DISCO (Root /) ---"
    df -h / | awk 'NR==2 {print "Partizione: " $1 " | Usato: " $5 " | Disponibile: " $4}'
}

# 4. Attivazione Log se $output NON è vuoto (-n)
if [[ -n "$output" ]]; then
    exec 3>&1
    exec 1> "$output"
fi

# 5. Esecuzione condizionale delle funzioni
if [[ "$mem" == true ]]; then
    check_memory
fi

if [[ "$disk" == true ]]; then
    check_disk
fi

# 6. Ripristino Schermo (se il log era attivo)
if [[ -n "$output" ]]; then
    exec 1>&3
    exec 3>&-
    echo "[OK] Report salvato con successo nel file: $output"
fi
