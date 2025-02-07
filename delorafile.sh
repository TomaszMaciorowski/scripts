#!/usr/bin/python
import os
import time

# Ścieżka do głównego katalogu
backup_dir = '/oracle/SOL/oraarch/'

# Ustaw granicę czasową na 30 dni temu
cutoff_date = time.time() - 30 * 86400  # 30 dni w sekundach

# Pobierz wszystkie pliki kończące się na .dbf
files = [os.path.join(backup_dir, f) for f in os.listdir(backup_dir)
         if os.path.isfile(os.path.join(backup_dir, f)) and f.endswith('.dbf')]

# Sortuj pliki według daty modyfikacji (od najnowszego do najstarszego)
files.sort(key=lambda x: os.path.getmtime(x), reverse=True)

# Zachowaj 24 najnowsze pliki
files_to_check = files[24:]

# Usuń pliki starsze niż 30 dni
for file_path in files_to_check:
    if os.path.getmtime(file_path) < cutoff_date:
        os.remove(file_path)
        print(f"Usunięto plik: {file_path}")
    else:
        print(f"Plik {file_path} jest nowszy niż 30 dni, nie usuwam.")

