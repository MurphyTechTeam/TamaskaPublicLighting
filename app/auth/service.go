package auth

import (
	"errors"

	"github.com/dgrijalva/jwt-go"
)

var SECRET_KEY = []byte("TAMASKA_PJU_U_JP_AKS_AMTA_RIZW")

var ApplicationAntares = "Smart-PJU"
var SECRET_ANTARES = "0b6b7781f24344d5:b0ec30902bc42bdf"
var ApplicationURL = "https://platform.antares.id:8443/~/antares-cse/antares-id/Smart-PJU"

var Application = "SmartPJU"
var SECRET_SCNHUB = "GvMObAk3Rh9LItsB:Vh2ypjwObm2duOMs"
var ApplicationSCN = "http://172.17.62.60:8765/SCN-iot/SmartPJU/"

var AuthUser = "scan"
var AuthPassword = "sCan@TamaskA209#"

type Service interface {
	ValidateToken(token string) (*jwt.Token, error)
	GenerateToken(userID int) (string, error)
}

type jwtService struct {
}

func NewService() *jwtService {
	return &jwtService{}
}

func (s *jwtService) ValidateToken(encodedToken string) (*jwt.Token, error) {
	token, err := jwt.Parse(encodedToken, func(token *jwt.Token) (interface{}, error) {
		_, ok := token.Method.(*jwt.SigningMethodHMAC)
		if !ok {
			return nil, errors.New("Invalid token")
		}

		return []byte(SECRET_KEY), nil
	})

	if err != nil {
		return token, err
	}

	return token, nil
}

func (s *jwtService) GenerateToken(userID int) (string, error) {
	claim := jwt.MapClaims{}
	claim["user_id"] = userID

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claim)

	signedToken, err := token.SignedString(SECRET_KEY)
	if err != nil {
		return signedToken, err
	}

	return signedToken, nil
}
