# 🛍️ TP E-Commerce – Flutter

Ce projet est une application e-commerce réalisée en Flutter dans le cadre du cours.  
Elle inclut un catalogue produits, un panier, un checkout avec paiement simulé, et la création/persistance locale de commandes.

---

## 🌐 Déploiement

L’application est déployée en version Web grâce à Vercel :  
👉 **https://flutter-e-shop.vercel.app/**

---

## 🚀 Fonctionnalités

### ✔️ Catalogue produits

- Affichage d’une liste de produits (image, nom, prix, description).
- Navigation vers une page de détails.
- Ajout d’un produit au panier.

### ✔️ Panier

- Liste des produits ajoutés.
- Modification des quantités (+ / –).
- Suppression d’un article.
- Mise à jour automatique du total.

### ✔️ Checkout (paiement simulé)

- Récapitulatif complet du panier.
- Formulaire de paiement (mock, aucune transaction réelle).
- Confirmation de commande après validation.
- **Vidage automatique du panier après paiement.**

### ✔️ Gestion des commandes

- Création d’une commande après le paiement.
- Stockage local via **SharedPreferences**.
- Récupération des commandes disponibles.

---
