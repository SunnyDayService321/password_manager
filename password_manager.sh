#!/bin/bash
while true; do
    echo "パスワードマネージャーへようこそ！"
    echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
    read choice

    case $choice in
        "Add Password")
            echo "サービス名を入力してください："
            read service_name
            echo "ユーザー名を入力してください："
            read username
            echo "パスワードを入力してください："
            read -s password

            echo "$service_name:$username:$password" >> passwords.txt
            echo "パスワードの追加は成功しました。"
            ;;

        "Get Password")
            echo "サービス名を入力してください："
            read search_service
            found=false

            while IFS=: read -r service user pass; do
                if [[ $service == $search_service ]]; then
                    echo "サービス名：$service"
                    echo "ユーザー名：$user"
                    echo "パスワード：$pass"
                    found=true
                    break
                fi
            done < passwords.txt

            if ! $found; then
                echo "そのサービスは登録されていません。"
            fi
            ;;

        "Exit")
            echo "Thank you!"
            break
            ;;

        *)
            echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
            ;;
    esac
done

