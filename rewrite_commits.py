import datetime

start_date = datetime.datetime(2025, 7, 23, 12, 0, 0)  # data per l'ultimo commit
davide_name = b"DavideOrienti"
davide_email = b"orientidavide@gmail.com"
matteo_name = b"matteo2911"
matteo_email = b"mat.romeo@stud.uniroma3.it"

def commit_callback(commit, metadata):
    # Calcola l'indice del commit
    idx = metadata.commit_count - metadata.current_commit
    # Alterna autore/committer
    if idx % 2 == 0:
        commit.author_name = davide_name
        commit.author_email = davide_email
        commit.committer_name = davide_name
        commit.committer_email = davide_email
    else:
        commit.author_name = matteo_name
        commit.author_email = matteo_email
        commit.committer_name = matteo_name
        commit.committer_email = matteo_email

    # Calcola data: ogni commit 2 giorni prima del successivo
    commit_date = start_date - datetime.timedelta(days=2 * idx)
    date_str = commit_date.strftime("%a, %d %b %Y %H:%M:%S +0200")
    commit.author_date = date_str.encode()
    commit.committer_date = date_str.encode()