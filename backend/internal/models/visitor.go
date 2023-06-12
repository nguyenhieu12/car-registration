package models

//type InspList []*Inspection
//type StaList []*Station
//
//type Pair struct {
//	*Inspection `json:"inspection"`
//	*Station    `json:"station"`
//}
//
//type PairResult []*Pair
//type Visitor struct {
//	*Vehicle    `json:"vehicle"`
//	*PairResult `json:"pair"`
//}

type Pair struct {
	*Inspection `json:"inspection"`
	*Station    `json:"station"`
}

type PairResult []*Pair

type Visitor struct {
	Vehicle *Vehicle   `json:"vehicle"`
	Pair    PairResult `json:"pair"`
}
