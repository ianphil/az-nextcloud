#!/bin/bash

function clean_sub() {
    echo "Getting all groups..."
    allGroups=$(az group list --query [].name --output tsv)
    echo "Getting groups to keep..."
    keepGroups=$(az group list --tag Remove=no --query [].name --output tsv)
    echo "Getting groups to remove from diff..."
    removeGroups=$(echo "$allGroups" | grep -v "$keepGroups")

    for rg in $removeGroups
    do
        echo "Deleting group: " $rg
        az group delete --name $rg --yes
    done
}