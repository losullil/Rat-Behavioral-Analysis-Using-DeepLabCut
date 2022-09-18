import deeplabcut

config_path = '/mnt/research/jhoneycu/losulliv/KAT_OFT_R/config.yaml'
deeplabcut.train_network(config_path, shuffle=1, saveiters=5000, maxiters=200000)
