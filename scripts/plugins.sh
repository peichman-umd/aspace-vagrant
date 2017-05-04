#/bin/bash


SERVICE_USER_GROUP=vagrant:vagrant

# load plugins
cd /apps/aspace/archivesspace/plugins
git clone https://github.com/umd-lib/umd-lib-aspace-theme.git && cd umd-lib-aspace-theme && git checkout 1.0.0 && cd ..
git clone https://github.com/lyrasis/aspace-search-identifier.git && cd aspace-search-identifier && git checkout df2236f1bfb0bd1c29f2fecf17f07df152bc8d80 && cd ..
git clone https://github.com/dartmouth-dltg/aspace-omniauth-cas.git && cd aspace-omniauth-cas && git checkout ed84e573b4fd5fc8e50bbea223dbc2e6f11ad863 && cd ..
git clone https://github.com/hudmol/payments_module.git && cd payments_module && git checkout v1.5.x-1.1 && cd ..
git clone https://github.com/hudmol/aspace_yale_accessions.git && cd aspace_yale_accessions && git checkout 0.10 && cd ..
git clone https://github.com/hudmol/default_text_for_notes.git && cd default_text_for_notes && git checkout v1.3.x-1.2 && cd ..
git clone https://github.com/hudmol/and_search.git && cd and_search && git checkout v0.1 && cd ..

chown -R "$SERVICE_USER_GROUP" /apps/aspace/archivesspace/plugins

# tweaks the plugin to migration automagically
sed -i  's/while true/while false/' payments_module/migrations/002_load_fund_codes.rb 


cd /apps/aspace/archivesspace

source /apps/aspace/config/env

./scripts/initialize-plugin.sh aspace-omniauth-cas
./scripts/setup-database.sh
