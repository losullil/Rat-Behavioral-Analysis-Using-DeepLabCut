import deeplabcut

config_path = '/mnt/research/jhoneycu/losulliv/KAT_OFT_R/KAT_OFT_R-lucyosullivan-2022-09-17/config.yaml'
deeplabcut.analyze_videos(config_path,['/mnt/research/jhoneycu/losulliv/KAT_OFT_R/KAT_OFT_R-lucyosullivan-2022-09-17/videos/'],save_as_csv=True)
