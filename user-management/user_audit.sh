#!/bin/bash

user_shell=""
uid_min=""
log_file=""
log_enable=false

# 1. Parsing CLI (Aggiunti i due punti a l:)
while getopts "s:u:l:h" opt; do
    case "${opt}" in
        s) user_shell="$OPTARG" ;;
        u) uid_min="$OPTARG" ;;
        l) 
            log_file="$OPTARG"
            log_enable=true
            ;;
        h) 
            echo "[HELP] USAGE: $0 [-s /bin/bash] [-u 1000] [-l log.txt]"
            exit 0
            ;;
        ?) 
            echo "[ERROR] INVALID ARGUMENT"
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))

# 2. Fail-Fast: Errore SOLO se entrambi sono vuoti (&&)
if [[ -z "$user_shell" && -z "$uid_min" ]]; then
    echo "[ERROR] At least option [-s] or [-u] is needed!"
    exit 1
fi

# 3. Validazione UID (deve permettere anche lo 0)
if [[ -n "$uid_min" ]] && ! [[ "$uid_min" =~ ^[0-9]+$ ]]; then
    echo "[ERROR] UID must be a non-negative integer!"
    exit 1
fi

# 4. Attivazione Log
if [[ "$log_enable" == true ]]; then
    exec 3>&1
    exec 1> "$log_file"
fi

# 5. Funzione di Audit
audit_user() {
    local shell="$1"
    local uid="$2"

    echo "--- USER AUDIT REPORT ---"

    # Filtriamo /etc/passwd con gawk
    gawk -F':' -v target_shell="$shell" -v min_uid="$uid" '
    BEGIN {
        # Se min_uid è vuoto, lo impostiamo a -1 per non filtrare sull'UID
        if (min_uid == "") min_uid = -1;
    }
    {
        # Verifica delle condizioni: shell corrisponde (se passata) e UID >= min_uid
        match_shell = (target_shell == "" || $NF == target_shell);
        match_uid   = ($3 >= min_uid);

        if (match_shell && match_uid) {
            print "USER: " $1 " | UID: " $3 " | SHELL: " $NF
        }
    }' /etc/passwd
}

# Chiamata funzione
audit_user "$user_shell" "$uid_min"

# 6. Ripristino Log (Sintassi corretta: 1>&3)
if [[ "$log_enable" == true ]]; then
    exec 1>&3
    exec 3>&-
    echo "[SAVED] Log saved into $log_file"
fi
