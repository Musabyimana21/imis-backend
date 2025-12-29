#!/bin/bash

show_menu() {
    clear
    echo ""
    echo "  ========================================================"
    echo "  IMIS - Ishakiro Information Management System"
    echo "  ========================================================"
    echo ""
    echo "  [1] Start IMIS (Automatic Setup)"
    echo "  [2] Stop IMIS"
    echo "  [3] Test System Health"
    echo "  [4] Create Admin User"
    echo "  [5] View Logs (Docker)"
    echo "  [6] Open Frontend (Browser)"
    echo "  [7] Open API Docs (Browser)"
    echo "  [8] Exit"
    echo ""
    echo "  ========================================================"
    echo ""
}

while true; do
    show_menu
    read -p "Select option (1-8): " choice
    
    case $choice in
        1)
            clear
            echo "Starting IMIS..."
            ./setup.sh
            read -p "Press Enter to return to menu..."
            ;;
        2)
            clear
            echo "Stopping IMIS..."
            ./stop.sh
            read -p "Press Enter to return to menu..."
            ;;
        3)
            clear
            ./test-system.sh
            read -p "Press Enter to return to menu..."
            ;;
        4)
            clear
            ./create-admin.sh
            read -p "Press Enter to return to menu..."
            ;;
        5)
            clear
            echo "Viewing Docker logs..."
            docker-compose logs -f
            ;;
        6)
            clear
            echo "Opening frontend..."
            if command -v xdg-open &> /dev/null; then
                xdg-open http://localhost:5173
            elif command -v open &> /dev/null; then
                open http://localhost:5173
            else
                echo "Please open http://localhost:5173 in your browser"
            fi
            read -p "Press Enter to return to menu..."
            ;;
        7)
            clear
            echo "Opening API documentation..."
            if command -v xdg-open &> /dev/null; then
                xdg-open http://localhost:8000/docs
            elif command -v open &> /dev/null; then
                open http://localhost:8000/docs
            else
                echo "Please open http://localhost:8000/docs in your browser"
            fi
            read -p "Press Enter to return to menu..."
            ;;
        8)
            clear
            echo "Thank you for using IMIS!"
            sleep 2
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            sleep 2
            ;;
    esac
done
